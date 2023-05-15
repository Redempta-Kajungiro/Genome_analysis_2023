##Installing packages
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("pasilla")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("DESeq2")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("apeglm")
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("viridis")

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("pheatmap")

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("vsn")
library("vsn")
library(viridis)
library(apeglm)
library(pasilla)
library(DESeq2)
library(dplyr)
library(ggplot2)
library(scales)
library("pheatmap")

#the matrix of read counts 
#column data
coldataRNA <-  read.csv("sampleTable1.csv",sep=",",row.names=1)
coldataRNA$condition <- factor(coldataRNA$condition)
coldataRNA$Cultures <- factor(coldataRNA$Cultures)

#The count matrix 
dataM <-  read.csv("data-2023-05-02_1.csv",sep=",", row.names=1)
data_M <- as.matrix(dataM)
all(rownames(coldataRNA) == colnames(data_M))
#build the DESeqDataSet
dds <- DESeqDataSetFromMatrix(countData = data_M,
                              colData = coldataRNA,
                              design = ~ condition)
##Differential expression analysis
dds <- DESeq(dds)
dds
#DESeq results
res001 <- results(dds, alpha=0.001)
summary(res001)
sum(res001$padj < 0.001, na.rm=TRUE)
sum(res001$padj < 0.001 & abs(res001$log2FoldChange)>2, na.rm=TRUE)


##MA-plot
# Using DEseq2 built in method
plotMA(res001)
# Coerce to a data frame
deseq2ResDF <- as.data.frame(res001)
deseq2ResDF

# Examine this data frame
head(deseq2ResDF)

# Set a boolean column for significance
deseq2ResDF$significant <- ifelse(deseq2ResDF$padj < .001, "Significant", NA)

# Plot the results similar to DEseq2
ggplot(deseq2ResDF, aes(baseMean, log2FoldChange, colour=significant)) + geom_point(size=1) + scale_y_continuous(limits=c(-3, 3), oob=squish) + scale_x_log10() + geom_hline(yintercept = 0, colour="tomato1", size=2) + labs(x="mean of normalized counts", y="log fold change") + scale_colour_manual(name="q-value", values=("Significant"="red"), na.value="grey50") + theme_bw()

# Let's add some more detail
ggplot(deseq2ResDF, aes(baseMean, log2FoldChange, colour=padj)) + geom_point(size=1) + scale_y_continuous(limits=c(-3, 3), oob=squish) + scale_x_log10() + geom_hline(yintercept = 0, colour="darkorchid4", size=1, linetype="longdash") + labs(x="mean of normalized counts", y="log fold change") + scale_colour_viridis(direction=-1, trans='sqrt') + theme_bw() + geom_density_2d(colour="black", size=2)

##Heatmap of the count matrix
##transformations on the variance
# this gives log2(n + 1)
ntd <- normTransform(dds)
meanSdPlot(assay(ntd))
select <- order(rowMeans(counts(dds,normalized=FALSE)),
                decreasing=TRUE)[1:20]

df <- as.data.frame(colData(dds)[,c("condition","Cultures")])

##plot heatmap of differentially expressed genes 
pheatmap(assay(ntd)[select,], cluster_rows=FALSE, show_rownames=TRUE,
         cluster_cols=TRUE, annotation_col=df)


