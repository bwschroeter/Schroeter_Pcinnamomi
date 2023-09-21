source("../shared_scripts/sample_names.R", 
       local = knitr::knit_global())

colData <- coldata %>% 
  filter(str_detect(Sample, "Pc"))

rownames(colData) <- colData$Sample
colData <- colData [ ,-1] 

source("../shared_scripts/countmatrix.R", 
       local = knitr::knit_global())

# making sure the row names in colData matches to column names in counts_data
all(colnames(IUM83CountMatrix) %in% rownames(colData))

library(DESeq2)

# Create sample information
sampleNames <- colData$Sample
condition <- colData$Stage
timepoint <- colData$Time

colDATA <- data.frame(sampleNames,
                      condition,
                      timepoint,
                      stringsAsFactors = T)

# Create the DESeqDataSet object
dds <- DESeqDataSetFromMatrix(countData = IUM83CountMatrix,
                              colData = colDATA,
                              design = ~ condition)

dds <- dds[rowMeans(counts(dds)) >10,]

dds$condition <- relevel(dds$timepoint, ref = "0h")

dds <- DESeq(dds)

as.data.frame(colData(dds))


# To compare "Early" vs "Vegetative"
res_early_vs_vegetative <- results(dds, contrast = c("condition", "18h", "0h"))

# To compare "Middle" vs "Vegetative"
res_middle_vs_vegetative <- results(dds, contrast =c ("condition", "30h", "0h"))

# To compare "Late" vs "Vegetative"
res_late_vs_vegetative <- results(dds, contrast = c("condition", "48h", "0h"))



