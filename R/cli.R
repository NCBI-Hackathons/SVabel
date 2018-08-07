library("optparse")

option_list <- list(
    make_option("--lshift", type="integer", default=0,
                help="Number of bp to left of target breakpoint [%default]"),
    make_option("--rshift", type="integer", default=0,
                help="Number of bp to left of target breakpoint [%default]"),
    make_option(c("-C", "--cooridinate-system"), type="character", default="hg19",
                help="Coordinate system (hg19/hg38) [%default]"),
    make_option(c("-A", "--annotation-format"), type="character", default="GENCODE",
                help="Annotation format (GENCODE/Ensembl) [%default]"),
    make_option(c("-F", "--input-format"), type="character", default="VCF",
                help="Input format (VCF/BEDPE) [%default]"),
    make_option(c("-i", "--annotations-file"), type="character", default="annotations.gtf",
                help="Output file [%default]"),
    make_option(c("-o", "--output-file"), type="character", default="sv.out",
                help="Output file [%default]")
);

# gtf, gff, metadata file
USAGE = "usage: %prog [options] input-file"
DESCRIPTION = "Simple tool to annotate Structural Variants"
opt_parser <- OptionParser(option_list=option_list, description=DESCRIPTION,
                           usage=USAGE);
options <- parse_args2(opt_parser);

# Input filename is the only positional argument, also need to split
# Will ignore additional positional arguments
args <- options$args
parts <- strsplit(args, " +")
tryCatch(
    { filename <- parts[[1]] },
    error = function(e){ filename <<- "" }
)
if (!nchar(toString(filename))){
    print_help(opt_parser)
    stop("Supply an input filename", call.=FALSE)
}

# Just show what file is being used
print(paste0("Using '", filename, "' as input file"))
