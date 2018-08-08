source("https://bioconductor.org/biocLite.R")
biocLite("VariantAnnotation")
library(VariantAnnotation)
install.packages("stringr")
library(stringr)
install.packages("stringi")
library(stringi)

readfile <- function() 
{
  # Ask user for name of VCF file
  filename<-readline(prompt="Enter path and name of .VCF or .VCF.GZ file.")
  # If the user enters the path with quotes, then remove quotes and the backslash that R adds
  filename<-gsub('\"', "", filename, fixed = TRUE)
  
  # Make sure that the user enters the correct file. Do not proceed unless file is .VCF or .VCF.GZ
  while (file.exists(filename)==FALSE)
  {
   print("File does not exist. Check the path and name of the file, including extension.")
     filename<-readline(prompt="Re-enter path and name of file. File must be .VCF or .VCF.GZ.")
     filename<-gsub('\"', "", filename, fixed = TRUE)
   }

  # Ask user if he/she is using hg19 data
  ans<-readline(prompt="Are you using hg19? y/n.")

   # Make sure user enters correct value
   while (toupper(ans) !="Y" && toupper(ans) !="N")
   {
     ans<-readline(prompt="Enter 'y' or 'n'.")
   }
  
   # Create value for gen parameter based on user input
   if (toupper(ans) == "Y") {
     gen="hg19"
   }
  
   else if (toupper(ans) == "N") {
     gen="hg38"
   }
  
   # Read in .VCF or .VCF.GZ file
   vcf_file <- readVcf(filename, genome=gen)
  
   # Convert S4 data object to data frame
   vcf <- rowRanges(vcf_file)
  }

readfile()

