#Script containing code to preprocess NCBI data, intergrating gene/protein with GO terms from omicsbox file.

library(tidyverse)
library(clusterProfiler)
#Load Phytophthora cinnamomi gtf file, clean up to get Gene IDs
#Combine alternatively spliced transcripts (seen in transcript_id as -RA and RB)

library(rtracklayer)
pc.gtf <- rtracklayer::import("https://ftp.ncbi.nlm.nih.gov/genomes/genbank/protozoa/Phytophthora_cinnamomi/latest_assembly_versions/GCA_018691715.1_ASM1869171v1/GCA_018691715.1_ASM1869171v1_genomic.gtf.gz")

pc.df <- as.data.frame((pc.gtf))

library(dplyr)

pc.genes <- filter(pc.df, type == "start_codon")

pc.geneids <- dplyr::select(pc.genes, gene_id, product, protein_id)  

pc.annotations <- pc.geneids %>% 
  distinct(gene_id, .keep_all = T)

pcannot <- as.matrix(pc.annotations)

#download .faa file 
#https://ftp.ncbi.nlm.nih.gov/genomes/genbank/protozoa/Phytophthora_cinnamomi/latest_assembly_versions/GCA_018691715.1_ASM1869171v1/GCA_018691715.1_ASM1869171v1_protein.faa.gz

library(Biostrings)

# Read the .faa file
faa_file <- "GCA_018691715.1_ASM1869171v1_protein.faa"  
sequences <- readAAStringSet(faa_file)

# Extract headers and sequences
headers <- names(sequences)
sequence_strings <- as.character(sequences)

# Extract protein identifiers from headers
protein_identifiers <- sub("^>(\\S+).*", "\\1", headers)

# Create a data frame with protein identifiers and sequences
df <- data.frame(protein_id = protein_identifiers, Sequence = sequence_strings, stringsAsFactors = FALSE)

# Filter the "ProteinID" column to include only the first 12 characters
df$protein_id <- substr(df$protein_id, 1, 12)

gtf.faa <- dplyr::right_join(df, pc.genes, by = 'protein_id') 
gtf.faa <- gtf.faa[, c(1,2,12, 19)]

#Load GO terms blasted from Omicsbox 
goterms <- read.delim('pc.goterms.txt', header = TRUE) %>%
  dplyr::select(c(SeqName, GO.IDs, GO.Names, Description))

colnames(goterms) <- c("protein_id", "GO_terms", "GO_descripton", "description")

gtf.faa.omicsbox <- dplyr::right_join(gtf.faa, goterms, by = 'protein_id')

gtf.omicsbox <- dplyr::select(gtf.faa.omicsbox, c("protein_id", "gene_id", "product", "GO_terms", "GO_descripton", "description"))

head(gtf.faa.omicsbox)



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

genesets <- read.gmt("goterms.gmt")

#original term F.GO.0005515.F.protein.binding

#modified term GO:0005515 F protein binding 
#with an additional column labelled ontologies where;
#F = Molecular function, C = Cellular component, and P = Biological process 


modifygenesetsfunction <- function(genesets) {
  genesets$original_term <- genesets$term
  genesets$term <- gsub("GO\\.", "GO:", genesets$term)
  genesets$term <- gsub("\\.", " ", genesets$term)
  genesets$ontology <- NA
  genesets$ontology[substr(genesets$term, 1, 1) == "F"] <- "Molecular function"
  genesets$ontology[substr(genesets$term, 1, 1) == "C"] <- "Cellular component"
  genesets$ontology[substr(genesets$term, 1, 1) == "P"] <- "Biological process"
  genesets$`GO term` <- substr(genesets$term, 3, 12)
  genesets$`GO description` <- substr(genesets$term, 16, nchar(genesets$term))
  genesets$`new_term` <- substr(genesets$term, 2, nchar(genesets$term))
  genesets <- genesets[complete.cases(genesets$ontology), ]
  return(genesets)
}

modifygenesets <- modifygenesetsfunction(genesets)

colnames(modifygenesets) <- c("modified", "gene", "ID","ontology", "GO", "description", "term")

# used in ORA
GOgenesets <- dplyr::select(modifygenesets, c("term", "gene"))
# used to add description to ORA result tables
GOdescription <- dplyr::select(modifygenesets, c("term","GO", "ontology", "description"))
colnames(GOdescription) <- c("ID", "GO", "ontology", "GO description")

