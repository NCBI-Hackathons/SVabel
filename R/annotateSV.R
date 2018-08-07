#library("rtracklayer")
#library("GenomicRanges")

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

annotateSV <- function (SVlist, gencode){
  data_gr = import(SVlist, format= "bedpe")
  gencode_df = readGFF(gencode)
  gencode_gr = makeGRangesFromDataFrame(gencode_df)
  gene_overlaps = findOverlaps(data_gr,gencode_gr,type = "within")
  return(gene_overlaps)
}

