# Install package so we are able to read in the GTF files
install.packages("refGenome")
library(refGenome)
install.packages("devtools")
library("devtools")
install.packages("R.utils")
library(R.utils)
devtools::document()
library(roxygen2)
source("https://bioconductor.org/biocLite.R")
biocLite("GenomicRanges")

setwd("C:/Users/Kelly/Documents/Hackathon")
devtools::create("sampledata")
devtools::use_data(exons_as_GRanges, internal=TRUE)

save(exons_as_GRanges,file="data/exongrangedata.Rdata")



setwd("C:/Users/Kelly/Documents/Hackathon/sampledata")
document()
devtools::create("data")

setwd("..")
getwd()
library("sampledata")
install("sampledata")


install.packages("~/sampledata")

document()
setwd("..")
getwd()
install("testdata")

setwd("C:/Users/Kelly/Downloads")

######## Read in Release 28 (GRCh38.p12), which is also known as hg38



gunzip("NA12878.sorted.vcf.gz")

read.gtf(gen, "gencode.v28.annotation.gtf")

gen <- ensemblGenome()


sampledata <-

