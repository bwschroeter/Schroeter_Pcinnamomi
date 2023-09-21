
library("mitch")
library("stringi")

setwd("../shared_scripts/")

source("../shared_scripts/pcinnamomi_annotations.R", 
       local = knitr::knit_global())

source("../shared_scripts/detected_pcgenes.R", 
       local = knitr::knit_global())






#genesets<-gmt_import("goterms.gmt")
genesets <- GOgenesets
#load("PcMitch.RData")

earlydetected <- as.data.frame(res_early_vs_vegetative)
middetected <- as.data.frame(res_middle_vs_vegetative)
latedetected <- as.data.frame(res_late_vs_vegetative)

# first rearrange cols
earlymitch <- earlydetected
earlymitch$MyGeneIDs<-rownames(earlymitch)
rownames(earlymitch)<-seq(nrow(earlymitch))
head(earlymitch)

midmitch <- middetected
midmitch$MyGeneIDs<-rownames(midmitch)
rownames(midmitch)<-seq(nrow(midmitch))
head(midmitch)

latemitch <- latedetected
latemitch$MyGeneIDs<-rownames(latemitch)
rownames(latemitch)<-seq(nrow(latemitch))
head(latemitch)

x<-list("Early"=earlymitch,"Mid"=midmitch, "Late"=latemitch)
y<-mitch_import(x,"DESeq2")


# obtain vector of gene names
genenames<-rownames(earlydetected)
# create fake accession numbers
accessions<-paste("Gene0",stri_rand_strings(nrow(earlymitch)*2, 6, pattern = "[0-9]"),sep="")
accessions<-head(unique(accessions),nrow(earlydetected))
# create a gene table file that relates gene names to accession numbers
gt<-data.frame(genenames,accessions)

# now swap gene names for accessions
earlymitch<-merge(earlydetected,gt,by.x=0,by.y="genenames")
rownames(earlymitch)<-earlymitch$accessions
earlymitch2<-earlymitch[,2:5]

midmitch<-merge(middetected,gt,by.x=0,by.y="genenames")
rownames(midmitch)<-midmitch$accessions
midmitch2<-midmitch[,2:5]

latemitch<-merge(latedetected,gt,by.x=0,by.y="genenames")
rownames(latemitch)<-latemitch$accessions
latemitch2<-latemitch[,2:5]

# now have a peek at the input data before importing
head(earlymitch2,3)
head(midmitch2,3)
head(latemitch2,3)
head(gt,3)
x<-list("Early"=earlymitch2,"Middle"=midmitch2, "Late"=latemitch2)
y<-mitch_import(x,DEtype="DESeq2",geneTable=gt)
head(y,3)

# prioritisation by significance
ressig<-mitch_calc(y,genesets,priority="significance", minsetsize = 5, cores=2)

# peek at the results
head(ressig$enrichment_result)

# prioritisation by effect size
reseffect<-mitch_calc(y,genesets,priority="effect", minsetsize = 5, cores=2)

head(reseffect$enrichment_result)

# prioritisation by SD
resSD<-mitch_calc(y,genesets,priority="SD", minsetsize = 5, cores=2)


head(resSD$enrichment_result)


## Generate a HTML report
#The HTML reports contain several plots as raster images and interactive charts
#which are useful as a first-pass visualisation. These can be generated like
#this:
  

mitch_report(ressig,"PcSIGNIFICANCEreport.html")
mitch_report(reseffect,"PcEFFECTreport.html")
mitch_report(resSD,"PcSDreport.html")



## Generate high resolution plots
#In case you want the charts in PDF format, for example for publications, these
#can be generated as such:
  

mitch_plots(res,outfile="Pccharts.pdf")

