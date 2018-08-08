library('GenomicInteractions')
library("GenomicRanges")
library("rtracklayer")
library('data.table')
library('gUtils')

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

#' @name is_valid_bedpe_file
#' @title Checks given a file, if it's a valid BEDPE file
#'
#' 
#' @param file BEDPE file
#' @param placeholderName prefix to use to ensure ids are unique
#'
#' @return True if the valid is a BEDPE file
#' @export
isValidBEDPEFile <- function(file, placeholderName="bedpe") {
	input <- as.data.frame(import(file,format='bedpe'))
  input <- fread(file)
  result <- "True"
	input_len <- length(input)   #check-length#
	if (input_len < 10) {
		print ("length of the input BEDPE has less than 10 columns!")}
		result <- "True"
for(i in 1:10) { #check typeof for the first 10 rows #
	if (typeof(t(input)[1, i])!='character') { # first column should contain the chromosome info
		result <- "False"} 
	if (as.integer(t(input)[2, i])) { # second column should contain the start position info
		result <- "False"} 
  if (as.integer(t(input)[3, i])) { # third column should contain the end position info
    result <- "False"} }
    return(result)
}

getBreakpointsGR <- function(file, placeholderName='') {
  data <-fread(file)
  startBreakpoints <- data.table(start=data[,c('V2')], seqnames=data[,c('V1')], end=data[,c('V3')], strand=data[,c('V9')]) # start breakpoints
  endBreakpoints <- data.table(start=data[,c('V5')], seqnames=data[,c('V4')], end=data[,c('V6')], strand=data[,c('V10')]) # end breakpoints
  # get common names
  setnames(startBreakpoints, 'start.V2', 'start')
  setnames(startBreakpoints, 'seqnames.V1', 'seqnames')
  setnames(startBreakpoints, 'end.V3', 'end')
  setnames(startBreakpoints, 'strand.V9', 'strand')

  setnames(endBreakpoints, 'start.V5', 'start')
  setnames(endBreakpoints, 'seqnames.V4', 'seqnames')
  setnames(endBreakpoints, 'end.V6', 'end')
  setnames(endBreakpoints, 'strand.V10', 'strand')
  allBreakpoints <- rbind(startBreakpoints, endBreakpoints)
  return(dt2gr(allBreakpoints))
}

# df <- data.frame(seqnames="chr1", tx_start=11:15, tx_end=12:16, strand=c("+","-","+","*","."), score=1:5)
# }
# data.table(start=data[,c('V2', 'V5')], seqnames=data[,c('V1', 'V4')], end=data[,c('V3', 'V6')], strand=data[,c('V9', 'V10')])
# # get_regions

getRegionGR <- function(file, placeholderName='') {
  data <-fread(file)
  dat <- data.table(start=data[,c('V2')], seqnames=data[,c('V1')], end=data[,c('V6')], strand=data[,c('V9')])
  return(dt2gr(dat))
}

classifySV <- function(file) {
  data <-fread(file)
  data_inv <- data[data$V11=='INVERSION']
  data_del <- data[data$V11=='DELETION']
  data_dup <- data[data$V11=='DUPLICATION']
  data_trans <- data[data$V11=='TRANSLOCATION']  
  return(data_trans) # figure out how to return all the dfs
}
classifySV('final3.bedpe')
getRegionGR('final3.bedpe')
getBreakpointsGR('final3.bedpe')
#main tests
# import into data.table 
# data <-fread('final2.bedpe')
# region <- data[,c('V1', 'V2', 'V6', 'V9')]
# break1 <- data[,c('V1', 'V2', 'V7')]
# break2 <- data[,c('V3', 'V4', 'V7')]
# rbind(break1, break2, use.names=TRUE, fill=TRUE, idcol=NULL) # doesn't do the right thing
