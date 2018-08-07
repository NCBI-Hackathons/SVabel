source("https://bioconductor.org/biocLite.R")
biocLite("VariantAnnotation")
library(VariantAnnotation)

# Ask user for path and name of file
readfile <- function()
  
{
  filename <- readline(prompt = "Enter path and name of VCF file.")
  return(filename)
  
  vcf_file <- readVcf(filename, genome="hg19")
  vcf <- rowRanges(vcf_file)
}

readfile()


# Read in the VCF file


# Convert to data frame


head(vcf)
keeps <- c("QUAL","ALT","ParamRangeID")
vcf[keeps]

library(GenomicRanges)
example_foo = GRanges('12:500-760')