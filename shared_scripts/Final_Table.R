library(stringi)

goterms <- read.delim('pc.goterms.txt', header = TRUE) %>% 
  dplyr::select(c(SeqName, GO.IDs, GO.Names, Description))

colnames(goterms) <- c("protein_id", "GO_terms", "GO_descripton", "description")

#Make GO term list 

splitgt.df <- as_tibble(goterms) %>%
  separate_longer_delim(c(GO_terms, GO_descripton), delim = ";")

splitgt.df <- as.data.frame(splitgt.df)

#strip leading spaces
splitgt.df$GO_terms <- gsub(" ","",splitgt.df$GO_terms)
splitgt.df$GO_descripton <- gsub("^ ","",splitgt.df$GO_descripton)

table <- read.csv("/mnt/data/barry/projects/Schroeter_Pcinnamomi/shared_scripts/effectortable.csv")
table <- subset(table, select = -c(Sequence))

tail(table,3)

splitgt.df <- splitgt.df %>%
  mutate(BP_GO_IDs = ifelse(grepl("^P:", GO_terms), gsub("^P:", "", GO_terms), "-"),
         MF_GO_IDs = ifelse(grepl("^F:", GO_terms), gsub("^F:", "", GO_terms), "-"),
         CC_GO_IDs = ifelse(grepl("^C:", GO_terms), gsub("^C:", "", GO_terms), "-")) 

splitgt.df <- splitgt.df %>%
  mutate(BP_Term = ifelse(grepl("^P:", GO_descripton), substr(GO_descripton, 3, nchar(GO_descripton)), "-"),
         MF_Term = ifelse(grepl("^F:", GO_descripton), substr(GO_descripton, 3, nchar(GO_descripton)), "-"),
         CC_Term = ifelse(grepl("^C:", GO_descripton), substr(GO_descripton, 3, nchar(GO_descripton)), "-"))

# Function to concatenate with semicolon if there are multiple elements, else keep the single element
concatenate_with_semicolon <- function(x) {
  if (length(unique(x)) > 1) {
    paste(unique(x), collapse = "; ")
  } else {
    unique(x)
  }
}

# Create a new dataframe with the collapsed protein_id
collapsed_df <- aggregate(. ~ protein_id, data = splitgt.df, FUN = concatenate_with_semicolon)


final.table <-  collapsed_df %>%
  left_join(table %>%
              dplyr::select(protein_id, gene_id, SP..TM, Prediction), by = "protein_id") 

final.table <- final.table %>% 
  dplyr::select(c(gene_id, protein_id, description, BP_Term, BP_GO_IDs, MF_Term, MF_GO_IDs, CC_Term, CC_GO_IDs, SP..TM, Prediction))


head(final.table,1)

write.csv(final.table, file = "/mnt/data/barry/projects/Schroeter_Pcinnamomi/shared_scripts/finaltable.tsv", row.names = FALSE)
