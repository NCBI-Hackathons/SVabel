
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