#' A annotation validator
#'
#' This function validates an annotation file
#'
#' It handles the following formats: GTF, GFF3, Metadata
#' @param file Path to file for validation
#' @keywords annotations, gtf, gff3, metadata
#' @export
#' @examples
#' validate_annotation_file(file)
validate_annotation_file <- function(file=NULL){
   print(file)
}

#' A annotation format detector
#'
#' This function detects the annotation file format
#'
#' It detects the following formats: GTF, GFF3, Metadata. This is very
#' naive and will simply check the file extension.
#'
#' @param file Path to file for detection
#' @keywords annotations, gtf, gff3, metadata
#' @export
#' @examples
#' detect_format(file)
# TODO(zeroslack): more robust detection
ALLOWED_FORMATS = c("gtf", "gff3", "metadata")
detect_format <- function(file=NULL){
    ext <- tools::file_ext(file)
    if(nchar(ext) == 0){
        warning("Input filename has no extension")
        return(NULL)
    }
    ext <- tolower(ext)
    if(any(ALLOWED_FORMATS == ext)){
        return(ext)
    } else {
        warning("Input filename has no extension")
        return(NULL)
    }
}

#' A GTF format validator
#'
#' This function validates the GTF file format
#'
#' @param file Path to file for validation
#' @keywords annotations, gtf
#' @export
#' @examples
#' validate_gtf_format(file)
validate_gtf_format <- function(file=NULL) {}

#' A GFF format validator
#'
#' This function validates the GFF file format
#'
#' @param file Path to file for validation
#' @keywords annotations, gff
#' @export
#' @examples
#' validate_gff_format(file)
validate_gff_format <- function(file=NULL) {}

#' A Metadata format validator
#'
#' This function validates the GTF file format
#'
#' @param file Path to file for validation
#' @keywords annotations, gtf
#' @export
#' @examples
#' validate_metadata_format(file)
validate_metadata_format <- function(file=NULL) {}
