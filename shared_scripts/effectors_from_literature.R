#Effectors from the literature including Pfam associated with pathogenesis and published effectors



interproscanresults <- read_tsv("allpcgenes.fasta.tsv")

colnames(interproscanresults) <- c("protein_id", "protein_md5", "protein_length", 
                                   "analysis", "signature_id", 
                                   "signature_desc", "start", "end", 
                                   "score", "status", "date", 
                                   "interpro_id", "interpro_desc", "go_terms")
head(interproscanresults)


#PFAM accessions associated with pathogenicity

#elicitin Pfam domain PF00964
PF00964 <- unique(interproscanresults[interproscanresults$signature_id == "PF00964",])
#serine protease inhibitor Kazal-like domain PF07648
PF07648 <- unique(interproscanresults[interproscanresults$signature_id == "PF07648",])
#chymotrypsin PF00089 
PF00089 <- unique(interproscanresults[interproscanresults$signature_id == "PF00089",])
#PAN/Apple domain PF14295 
PF14295 <- unique(interproscanresults[interproscanresults$signature_id == "PF14295",])
#Cathepsin propeptide inhibitor PF08246
PF08246 <- unique(interproscanresults[interproscanresults$signature_id == "PF08246",])
# Lytic polysaccharide mono-oxygenase PF03067
PF03067 <- unique(interproscanresults[interproscanresults$signature_id == "PF03067",])
#Transglutaminase_elicitor PF16683 
PF16683 <- unique(interproscanresults[interproscanresults$signature_id == "PF16683",])
#Cysteine_rich_secretory_protein_family PF00188 
PF00188 <- unique(interproscanresults[interproscanresults$signature_id == "PF00188",])
#Glycosyl_hydrolase_family_12 PF01670
PF01670 <- unique(interproscanresults[interproscanresults$signature_id == "PF01670",])
#pectin degradation (PF03283, PF00544, and PF03211)
PF03283 <- unique(interproscanresults[interproscanresults$signature_id == "PF03283",])
PF00544 <- unique(interproscanresults[interproscanresults$signature_id == "PF00544",])
PF03211 <- unique(interproscanresults[interproscanresults$signature_id == "PF03211",])

pfameffectors <- as.data.frame(unique(c(PF00964$protein_id, PF07648$protein_id, PF00089$protein_id, PF14295$protein_id, PF08246$protein_id, PF03067$protein_id, PF16683$protein_id, PF00188$protein_id, PF01670$protein_id, PF03283$protein_id, PF00544$protein_id, PF03211$protein_id)))

names(pfameffectors)[1] <- "protein_id"

pfameffectors.id <- dplyr::right_join(gtf.faa.omicsbox, pfameffectors, by = 'protein_id')
#177 proteins from PFAM domains known to be involved in pathogenicity

#Get supplementary files from https://rdcu.be/dcczO
#https://static-content.springer.com/esm/art%3A10.1186%2Fs12864-021-07552-y/MediaObjects/12864_2021_7552_MOESM2_ESM.xls


library(readxl)
#only considered the 181 candidate RxLR -IUM83_06578-RA/RB alternatively spliced total 180 rxlr
pcrxlr <- read_xls('12864_2021_7552_MOESM2_ESM.xls', 
                   sheet = 'TableS2',
                   col_names = F,
                   range = 'A3:A183') 
colnames(pcrxlr) <- c("gene_id")

# Remove the last three characters of each row
pcrxlr$gene_id <- substr(pcrxlr$gene_id, 1, nchar(pcrxlr$gene_id) - 3)

as.data.frame(pcrxlr)

rxlr.df <- Pcgenenames %>%
  filter(gene_id %in% pcrxlr$gene_id)

head(rxlr.df)


#49 CRNs (45 genes, of which four have alternative transcript variants)
pccrn <- read_xls('12864_2021_7552_MOESM2_ESM.xls', 
                  sheet = 'TableS3',
                  col_names = F,
                  range = 'A3:A51') 
# Rename the column
colnames(pccrn) <- c("gene_id")

# Remove the last three characters of each row
pccrn$gene_id <- substr(pccrn$gene_id, 1, nchar(pccrn$gene_id) - 3)

as.data.frame(pccrn)

crn.df <- Pcgenenames %>%
  filter(gene_id %in% pccrn$gene_id)

head(crn.df)

#61 necrosis-inducing proteins (NLPs)
pcnlp <- read_xls('12864_2021_7552_MOESM2_ESM.xls', 
                  sheet = 'TableS4',
                  col_names = F,
                  range = 'A3:A63') 
# Rename the column
colnames(pcnlp) <- c("gene_id")

# Remove the last three characters of each row
pcnlp$gene_id <- substr(pcnlp$gene_id, 1, nchar(pcnlp$gene_id) - 3)

as.data.frame(pcnlp)

nlp.df <- Pcgenenames %>%
  filter(gene_id %in% pcnlp$gene_id)

head(nlp.df)

#list of know effectors based on published data 
knowneffectors <- unique(c(nlp.df$protein_id, crn.df$protein_id, rxlr.df$protein_id))

knowneffectors.id <- gtf.faa.omicsbox[gtf.faa.omicsbox$protein_id %in% knowneffectors, ]
#286 proteins
