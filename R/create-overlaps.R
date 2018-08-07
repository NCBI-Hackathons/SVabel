library('GenomicInteractions')
library("GenomicRanges")
library("rtracklayer")
library('data.table')

# written by Tze
classifyType <- function(SV){
  
  if(!is.null(SV$V1) && !is.null(SV$V4)){
    #breakpoint in same chromosome, but in different strands
    inversion = SV %>% filter (V1==V4 && v9!=V10 ) 
    #convert inversions to Granges 
    inversion_gr = makeGRangesFromDataFrame(inversion)
    #breakpoint in different chromosome, but in the same strand
    translocation = SV %>% filter (V1 != V4 && V9==V10)
    translocation_gr = makrGRangesFromDataFrame (translocation)
  }
}

#' @name annotateSV
#' @title annotate SVs with genes based on gencode hg19 coordinates
#'
#'
#' outputs the number of overlapping elements
#' the inputs are two data files
#'
#' @param SVlist BEDPE file containing coordinates of structural variants
#' @param gencode  GTF file containing gene annotations from gencode
#' @return overlaps
#' 
# written by Tze
annotateSV <- function (SVlist, gencode){
  data_gr = import(SVlist, format= "bedpe")
  gencode_df = readGFF(gencode)
  gencode_gr = makeGRangesFromDataFrame(gencode_df)
  gene_overlaps = findOverlaps(data_gr,gencode_gr,type = "within")
  return(gene_overlaps)
}


validate_bedpe_file <- function(file) {
	input <- as.data.frame(import(file,format='bedpe'))
	#----check-length----#
	input_len <- length(input)
	if (input_len < 10) {
		print ("length of the input BEDPE has less than 10 columns!")}
		result <- "True"
	#----check-typeof for the first 10 rows ----#
for(i in 1:10) {
	if (typeof(t(input)[1, i])!='character') {
		result <- "False"
	}
	if (as.integer(t(input)[2, i])) {
		result <- "False"
	}
}
# ' Checks a BEDPE is valid or not
# ' @param file BEDPE file
# ' @param placeholderName prefix to use to ensure ids are unique
# '
# ' @return breakpoint GRanges object
# ' @export


#main tests
# import into data.table 
data <-fread('final.bedpe')
region <- data[,c('V1', 'V2', 'V6', 'V7')]
break1 <- data[,c('V1', 'V2', 'V7')]
break2 <- data[,c('V3', 'V4', 'V7')]
rbind(break1, break2, use.names=TRUE, fill=TRUE, idcol=NULL) # doesn't do the right thing
