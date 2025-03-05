## Title: winnowmap dotplots
## Author: Emmarie Alexander
## Date: 26 March 2024

## Note: Winnowmap doesn't innately produce PAFs. Therefore, you need to use
# the paftools.js script provided in minimap2 to convert the SAM files, 
# which is what winnowmap generates, to a PAF in order to use this code.

## Currently, this script uses the R package "pafr" to clean the PAF alignments
# but uses the Rscript "pafCoordsDotPlotly.R" written by Tom Poorten 
# (https://github.com/tpoorten/dotPlotly/tree/master)

## Purpose: This script was written using the pafr package to filter alignments
# generated using Winnowmap to extract the highest quality alignments that are
# most likely Y-linked.

### install pafr
# install.packages("devtools")
# devtools::install_github("dwinter/pafr")

### install packages for dotplotly
# install.packages(c("optparse", "ggplot2", "plotly"))

### load pafr
library(pafr, quietly=TRUE)

################# FILTERING AND DOTPLOT GENERATION #######################
### Here is an example of identifying dugong (DugDug) Y-chromosome sequenced from an alignment of the dugong to the elephant (EleMax, Elephas maximus indicus)
#### DugDug ####
EleMax_DugDug <- read_paf("EleMax_DugDug_chrX+Y_aln.paf")
EleMax_DugDug_filtered <- filter_secondary_alignments(EleMax_DugDug, remove_inversions=FALSE)
# filtering alignments that match my criteria to the EleMax's Y chromosome
EleMax_DugDug_filtered_chrY <- subset(EleMax_DugDug_filtered,
                                      tname %in% c("CM044048.1", "JAMZQU010000039.1", "JAMZQU010000040.1", "JAMZQU010000041.1", "JAMZQU010000042.1", "JAMZQU010000043.1", "JAMZQU010000044.1")
                                      & nmatch >= 500 & alen >= 500 & mapq >= 35)

# filtering alignments that match my criteria to the EleMax's X chromosome
EleMax_DugDug_filtered_chrX <- subset(EleMax_DugDug_filtered, tname=="CM044047.1" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(EleMax_DugDug_filtered_chrY, file="./EleMax_DugDug_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(EleMax_DugDug_filtered_chrX, file="./EleMax_DugDug_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i EleMax_DugDug_filtered_chrY.paf",
                         "-o EleMax_DugDug_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i EleMax_DugDug_filtered_chrX.paf",
                         "-o EleMax_DugDug_chrX_dotplot",
                         "-m 2000",
                         "-q 2000",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)
