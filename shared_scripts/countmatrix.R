# Script for making Phytophthora cinnamomi count matrix 

#Assemble count matrix and coldata file
library(reshape2)



tmp<-read.table("/mnt/data/barry/projects/Schroeter_Pcinnamomi/shared_scripts/3col.tsv.gz",header=F)

x<-as.matrix(acast(tmp, V2~V1, value.var="V3"))

colnames(x)<-sapply(strsplit(colnames(x),"_"),"[[",1)

IUM83Tanjilcountmatrix <- as.data.frame(x)

head(x)

#Import files into r

coldata <- read.table('sample_info.tsv')

Pcgenenames <- read.table('pcgeneids.tsv', row.names = 1, quote = "", sep='\t', fill = TRUE, header = TRUE)

#Clean countmatrix for P. cinnamomi analysis

collabels <- colnames(IUM83Tanjilcountmatrix) <- (coldata$Sample)

colnames(IUM83Tanjilcountmatrix) <- collabels

IUM83Tanjilcountmatrix <- tibble::rownames_to_column(IUM83Tanjilcountmatrix, "gene_id")

IUM83CountMatrix <- IUM83Tanjilcountmatrix %>% 
  dplyr::filter(str_detect(gene_id, "IUM83")) 

rownames(IUM83CountMatrix) <- IUM83CountMatrix$gene_id

IUM83CountMatrix <- IUM83CountMatrix [ ,-1]

IUM83CountMatrix <- as.data.frame(IUM83CountMatrix)

IUM83CountMatrix <- IUM83CountMatrix[ ,-(1:12)]

head(IUM83CountMatrix)
