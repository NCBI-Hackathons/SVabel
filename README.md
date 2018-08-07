[![Build Status](https://travis-ci.org/NCBI-Hackathons/SuperSnV.svg?branch=master)](https://travis-ci.org/NCBI-Hackathons/SuperSnV)
[![codecov.io](https://img.shields.io/codecov/c/github/NCBI-Hackathons/SuperSnV.svg)](https://img.shields.io/codecov/c/github/NCBI-Hackathons/SuperSnV?branch=master)


# SuperSnV

This package contains helper functions to annotate structural variants (SVs) and single nucleotide variants (SNVs) from either a VCF-format or BEDPE-format file.

## Installation

```
devtools::install_github('NCBI-Hackathons/supersnv')
```

## Dependencies 

The package relies on `data.table` and Bioconductor dependencies. 



## Usage

List of helper functions:-    
* `gtfValidator` check Annotation version and check genome build (currently supports hg19 and hg38)
* `vcfValidator` check if this is VCF 4.2/VCF4.1, and split data into SNVs  and SV)
* `classifySV` based on insertion/deletion/translocation/inversion/tandem duplications
* `classifySNV` (based on length of SNV)
* `annotateVariant` find_overlap and based on the available annotation, annotate exons, intergenic region, low complexity region,  transcription factor binding site
* `bedPEValidator` check if this is a bedPE file
*	`checkBreakpoints` check if these SV breakpoints are within the ranges of the genome build
*	`classifiySNV` should be modular and can be plugged into incorporate VCF results
* `annotateVariant` find_overlap and based on the available annotation, annotate exons, intergenic region, low complexity region,  transcription factor binding site)
* `useGTeX` optional to allow users to incorporate GTex expression data/ user’s data)
* `createOutput` print output files


### Contributors

* Evan Biederstedt 
* Kundai Andrew Midzi
* Tze Yin Lim
* Naina Thangaraj
* Kelly Terlizzi
* Peng Zhang

This project was initiated at an NCBI-style hackathon at the NYGC on August 2018.