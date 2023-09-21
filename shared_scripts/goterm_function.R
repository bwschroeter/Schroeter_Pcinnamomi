#Script used to create goterms.gmt file used for Mitch and enrichment analysis

#Load GO terms blasted from Omicsbox 

goterms <- read.delim('pc.goterms.txt', header = TRUE) %>% 
  dplyr::select(c(SeqName, GO.IDs, GO.Names, Description))

colnames(goterms) <- c("protein_id", "GO_terms", "GO_descripton", "description")

goterms.df <- dplyr::right_join(goterms, pc.annotations, by = 'protein_id')

#Make GO term list 

splitgt.df <- as_tibble(goterms.df) %>%
  separate_longer_delim(c(GO_terms, GO_descripton), delim = ";")

splitgt.df <- as.data.frame(splitgt.df)

#strip leading spaces
splitgt.df$GO_terms <- gsub(" ","",splitgt.df$GO_terms)
splitgt.df$GO_descripton <- gsub("^ ","",splitgt.df$GO_descripton)

gu <- unique(splitgt.df$GO_terms)

gul <- lapply(1:length(gu), function(i){
  mygo <- gu[i]
  unique(splitgt.df[splitgt.df$GO_terms == mygo, "gene_id"])
})

names(gul) <- lapply(1:length(gu), function(i){
  mygo <- gu[i]
  desc <- head(splitgt.df[splitgt.df$GO_terms == mygo, "GO_descripton"],1)
  id_desc <- paste(mygo,desc)
})


writeGMT <- function (object, fname ){
  if (class(object) != "list") stop("object should be of class 'list'")
  if(file.exists(fname)) unlink(fname)
  for (iElement in 1:length(object)){
    write.table(t(c(make.names(rep(names(object)[iElement],2)),object[[iElement]])),
                sep="\t",quote=FALSE,
                file=fname,append=TRUE,col.names=FALSE,row.names=FALSE)
  }
}

writeGMT(object=gul,fname="goterms.gmt")

