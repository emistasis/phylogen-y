## Title: winnowmap dotplots
## Author: Emmarie Alexander
## Date first written: 26 March 2024
## Date last updated: 3 April 2024

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
### ALIGNMENTS TO ELEPHANT
#### DugDug ####
EleMax_DugDug <- read_paf("EleMax_DugDug_chrX+Y_aln.paf")
EleMax_DugDug_filtered <- filter_secondary_alignments(EleMax_DugDug, remove_inversions=FALSE)
EleMax_DugDug_filtered_chrY <- subset(EleMax_DugDug_filtered,
                                      tname %in% c("CM044048.1", "JAMZQU010000039.1", "JAMZQU010000040.1", "JAMZQU010000041.1", "JAMZQU010000042.1", "JAMZQU010000043.1", "JAMZQU010000044.1")
                                      & nmatch >= 500 & alen >= 500 & mapq >= 35)
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

#################

### ALIGNMENTS TO SQUIRREL
#### CavPor ####
SciCar_CavPor <- read_paf("SciCar_CavPor_chrX+Y_aln.paf")
SciCar_CavPor_filtered <- filter_secondary_alignments(SciCar_CavPor, remove_inversions=FALSE)
SciCar_CavPor_filtered_chrY <- subset(SciCar_CavPor_filtered, 
                                      tname %in% c("LR738610.1", "NC_062232.1:5831442-5845371", "NC_062232.1:5559629-5780020", "NC_062232.1:5861234-5994868") 
                                      & nmatch >= 500 & alen >= 500 & mapq >= 35)
SciCar_CavPor_filtered_chrX <- subset(SciCar_CavPor_filtered, tname=="LR738601.1" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(SciCar_CavPor_filtered_chrY, file="./SciCar_CavPor_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(SciCar_CavPor_filtered_chrX, file="./SciCar_CavPor_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i SciCar_CavPor_filtered_chrY.paf",
                         "-o SciCar_CavPor_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i SciCar_CavPor_filtered_chrX.paf",
                         "-o SciCar_CavPor_chrX_dotplot",
                         "-m 1000",
                         "-q 1000",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

#### CasCan ####
SciCar_CasCan <- read_paf("SciCar_CasCan_chrX+Y_aln.paf")
SciCar_CasCan_filtered <- filter_secondary_alignments(SciCar_CasCan, remove_inversions=FALSE)
SciCar_CasCan_filtered_chrY <- subset(SciCar_CasCan_filtered, 
                                      tname %in% c("LR738610.1", "NC_062232.1:5831442-5845371", "NC_062232.1:5559629-5780020", "NC_062232.1:5861234-5994868") 
                                      & nmatch >= 500 & alen >= 500 & mapq >= 35)
SciCar_CasCan_filtered_chrX <- subset(SciCar_CasCan_filtered, tname=="LR738601.1" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(SciCar_CasCan_filtered_chrY, file="./SciCar_CasCan_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(SciCar_CasCan_filtered_chrX, file="./SciCar_CasCan_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i SciCar_CasCan_filtered_chrY.paf",
                         "-o SciCar_CasCan_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i SciCar_CasCan_filtered_chrX.paf",
                         "-o SciCar_CasCan_chrX_dotplot",
                         "-m 1000",
                         "-q 1000",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)



#### HetGla ####
SciCar_HetGla <- read_paf("SciCar_HetGla_chrX+Y_aln.paf")
SciCar_HetGla_filtered <- filter_secondary_alignments(SciCar_HetGla, remove_inversions=FALSE)
SciCar_HetGla_filtered_chrY <- subset(SciCar_HetGla_filtered, 
                                      tname %in% c("LR738610.1", "NC_062232.1:5831442-5845371", "NC_062232.1:5559629-5780020", "NC_062232.1:5861234-5994868") 
                                      & nmatch >= 500 & alen >= 500 )
SciCar_HetGla_filtered_chrX <- subset(SciCar_HetGla_filtered, tname=="LR738601.1" & nmatch >= 500 & alen >= 500 & mapq >= 35)

# write alignments to new paf file
write.table(SciCar_HetGla_filtered_chrY, file="./SciCar_HetGla_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(SciCar_HetGla_filtered_chrX, file="./SciCar_HetGla_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i SciCar_HetGla_filtered_chrY.paf",
                         "-o SciCar_HetGla_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i SciCar_HetGla_filtered_chrX.paf",
                         "-o SciCar_HetGla_chrX_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)
#################

### ALIGNMENTS TO HUMAN
#### AotAza ####
HomSap_AotAza <- read_paf("HomSap_AotAza_chrX+Y_aln.paf")
HomSap_AotAza_filtered <- filter_secondary_alignments(HomSap_AotAza, remove_inversions=FALSE)
HomSap_AotAza_filtered_chrY <- subset(HomSap_AotAza_filtered, tname=="CP086569.2" & nmatch >= 500 & alen >= 500 & mapq >= 35)
HomSap_AotAza_filtered_chrX <- subset(HomSap_AotAza_filtered, tname=="CP068255.2" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(HomSap_AotAza_filtered_chrY, file="./HomSap_AotAza_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(HomSap_AotAza_filtered_chrX, file="./HomSap_AotAza_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i HomSap_AotAza_filtered_chrY.paf",
                         "-o HomSap_AotAza_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i HomSap_AotAza_filtered_chrX.paf",
                         "-o HomSap_AotAza_chrX_dotplot",
                         "-m 1000",
                         "-q 1000",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

#### CavPor ####
HomSap_CavPor <- read_paf("HomSap_CavPor_chrX+Y_aln.paf")
HomSap_CavPor_filtered <- filter_secondary_alignments(HomSap_CavPor, remove_inversions=FALSE)
HomSap_CavPor_filtered_chrY <- subset(HomSap_CavPor_filtered, tname=="CP086569.2" & nmatch >= 500 & alen >= 500 & mapq >= 35)
HomSap_CavPor_filtered_chrX <- subset(HomSap_CavPor_filtered, tname=="CP068255.2" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(HomSap_CavPor_filtered_chrY, file="./HomSap_CavPor_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(HomSap_CavPor_filtered_chrX, file="./HomSap_CavPor_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i HomSap_CavPor_filtered_chrY.paf",
                         "-o HomSap_CavPor_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i HomSap_CavPor_filtered_chrX.paf",
                         "-o HomSap_CavPor_chrX_dotplot",
                         "-m 1000",
                         "-q 1000",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

#### CasCan ####
HomSap_CasCan <- read_paf("HomSap_CasCan_chrX+Y_aln.paf")
HomSap_CasCan_filtered <- filter_secondary_alignments(HomSap_CasCan, remove_inversions=FALSE)
HomSap_CasCan_filtered_chrY <- subset(HomSap_CasCan_filtered, tname=="CP086569.2" & nmatch >= 500 & alen >= 500 & mapq >= 35)
HomSap_CasCan_filtered_chrX <- subset(HomSap_CasCan_filtered, tname=="CP068255.2" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(HomSap_CasCan_filtered_chrY, file="./HomSap_CasCan_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(HomSap_CasCan_filtered_chrX, file="./HomSap_CasCan_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i HomSap_CasCan_filtered_chrY.paf",
                         "-o HomSap_CasCan_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i HomSap_CasCan_filtered_chrX.paf",
                         "-o HomSap_CasCan_chrX_dotplot",
                         "-m 1000",
                         "-q 1000",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

#### HetGla ####
HomSap_HetGla <- read_paf("HomSap_HetGla_chrX+Y_aln.paf")
HomSap_HetGla_filtered <- filter_secondary_alignments(HomSap_HetGla, remove_inversions=FALSE)
HomSap_HetGla_filtered_chrY <- subset(HomSap_HetGla_filtered, tname=="CP086569.2" & nmatch >= 500 & alen >= 500)
HomSap_HetGla_filtered_chrX <- subset(HomSap_HetGla_filtered, tname=="CP068255.2" & nmatch >= 500 & alen >= 500)

# write alignments to new paf file
write.table(HomSap_HetGla_filtered_chrY, file="./HomSap_HetGla_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(HomSap_HetGla_filtered_chrX, file="./HomSap_HetGla_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i HomSap_HetGla_filtered_chrY.paf",
                         "-o HomSap_HetGla_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i HomSap_HetGla_filtered_chrX.paf",
                         "-o HomSap_HetGla_chrX_dotplot",
                         "-m 1000",
                         "-q 1000",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)


#### MicRav ####
HomSap_MicRav <- read_paf("HomSap_MicRav_chrX+Y_aln.paf")
HomSap_MicRav_filtered <- filter_secondary_alignments(HomSap_MicRav, remove_inversions=FALSE)
HomSap_MicRav_filtered_chrY <- subset(HomSap_MicRav_filtered, tname=="CP086569.2" & nmatch >= 500 & alen >= 500 & mapq >= 35)
HomSap_MicRav_filtered_chrX <- subset(HomSap_MicRav_filtered, tname=="CP068255.2" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(HomSap_MicRav_filtered_chrY, file="./HomSap_MicRav_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(HomSap_MicRav_filtered_chrX, file="./HomSap_MicRav_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i HomSap_MicRav_filtered_chrY.paf",
                         "-o HomSap_MicRav_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i HomSap_MicRav_filtered_chrX.paf",
                         "-o HomSap_MicRav_chrX_dotplot",
                         "-m 1000",
                         "-q 1000",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)


#################

### ALIGNMENTS TO LEMUR
#### MicRav ####
LemCat_MicRav <- read_paf("LemCat_MicRav_chrX+Y_aln.paf")
LemCat_MicRav_filtered <- filter_secondary_alignments(LemCat_MicRav, remove_inversions=FALSE)
LemCat_MicRav_filtered_chrY <- subset(LemCat_MicRav_filtered, tname=="CM036500.1" & nmatch >= 500 & alen >= 500 & mapq >= 35)
LemCat_MicRav_filtered_chrX <- subset(LemCat_MicRav_filtered, tname=="CM036499.1" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(LemCat_MicRav_filtered_chrY, file="./LemCat_MicRav_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(LemCat_MicRav_filtered_chrX, file="./LemCat_MicRav_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i LemCat_MicRav_filtered_chrY.paf",
                         "-o LemCat_MicRav_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i LemCat_MicRav_filtered_chrX.paf",
                         "-o LemCat_MicRav_chrX_dotplot",
                         "-m 1000",
                         "-q 1000",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)


#################

### ALIGNMENTS TO WHALE
#### GirCam ####
BalMus_GirCam <- read_paf("BalMus_GirCam_chrX+Y_aln.paf")
BalMus_GirCam_filtered <- filter_secondary_alignments(BalMus_GirCam, remove_inversions=FALSE)
BalMus_GirCam_filtered_chrY <- subset(BalMus_GirCam_filtered, tname=="CM020963.2" & nmatch >= 500 & alen >= 500 & mapq >= 35)
BalMus_GirCam_filtered_chrX <- subset(BalMus_GirCam_filtered, tname=="CM020962.2" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(BalMus_GirCam_filtered_chrY, file="./BalMus_GirCam_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(BalMus_GirCam_filtered_chrX, file="./BalMus_GirCam_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i BalMus_GirCam_filtered_chrY.paf",
                         "-o BalMus_GirCam_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i BalMus_GirCam_filtered_chrX.paf",
                         "-o BalMus_GirCam_chrX_dotplot",
                         "-m 1000",
                         "-q 1000",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

#### MonMon #### 
BalMus_MonMon <- read_paf("BalMus_MonMon_chrX+Y_aln.paf")
BalMus_MonMon_filtered <- filter_secondary_alignments(BalMus_MonMon, remove_inversions=FALSE)
BalMus_MonMon_filtered_chrY <- subset(BalMus_MonMon_filtered, tname=="CM020963.2" & nmatch >= 500 & alen >= 500 & mapq >= 35)
BalMus_MonMon_filtered_chrX <- subset(BalMus_MonMon_filtered, tname=="CM020962.2" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(BalMus_MonMon_filtered_chrY, file="./BalMus_MonMon_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(BalMus_MonMon_filtered_chrX, file="./BalMus_MonMon_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i BalMus_MonMon_filtered_chrY.paf",
                         "-o BalMus_MonMon_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i BalMus_MonMon_filtered_chrX.paf",
                         "-o BalMus_MonMon_chrX_dotplot",
                         "-m 1000",
                         "-q 1000",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)
#### TraJav ####
BalMus_TraJav <- read_paf("BalMus_TraJav_chrX+Y_aln.paf")
BalMus_TraJav_filtered <- filter_secondary_alignments(BalMus_TraJav, remove_inversions=FALSE)
BalMus_TraJav_filtered_chrY <- subset(BalMus_TraJav_filtered, tname=="CM020963.2" & nmatch >= 500 & alen >= 500 & mapq >= 35)
BalMus_TraJav_filtered_chrX <- subset(BalMus_TraJav_filtered, tname=="CM020962.2" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(BalMus_TraJav_filtered_chrY, file="./BalMus_TraJav_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(BalMus_TraJav_filtered_chrX, file="./BalMus_TraJav_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i BalMus_TraJav_filtered_chrY.paf",
                         "-o BalMus_TraJav_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i BalMus_TraJav_filtered_chrX.paf",
                         "-o BalMus_TraJav_chrX_dotplot",
                         "-m 1000",
                         "-q 1000",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)
#### BisBis ####
BalMus_BisBis <- read_paf("BalMus_BisBis_chrX+Y_aln.paf")
BalMus_BisBis_filtered <- filter_secondary_alignments(BalMus_BisBis, remove_inversions=FALSE)
BalMus_BisBis_filtered_chrY <- subset(BalMus_BisBis_filtered, tname=="CM020963.2" & nmatch >= 500 & alen >= 500 & mapq >= 35)
BalMus_BisBis_filtered_chrX <- subset(BalMus_BisBis_filtered, tname=="CM020962.2" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(BalMus_BisBis_filtered_chrY, file="./BalMus_BisBis_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(BalMus_BisBis_filtered_chrX, file="./BalMus_BisBis_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i BalMus_BisBis_filtered_chrY.paf",
                         "-o BalMus_BisBis_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i BalMus_BisBis_filtered_chrX.paf",
                         "-o BalMus_BisBis_chrX_dotplot",
                         "-m 1000",
                         "-q 1000",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)



#################

### ALIGNMENTS TO BULL
#### GirCam ####
BosTau_GirCam <- read_paf("BosTau_GirCam_chrX+Y_aln.paf")
BosTau_GirCam_filtered <- filter_secondary_alignments(BosTau_GirCam, remove_inversions=FALSE)
BosTau_GirCam_filtered_chrY <- subset(BosTau_GirCam_filtered, tname=="CM011803.1" & nmatch >= 500 & alen >= 500 & mapq >= 35)
BosTau_GirCam_filtered_chrX <- subset(BosTau_GirCam_filtered, tname=="CM011833.1" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(BosTau_GirCam_filtered_chrY, file="./BosTau_GirCam_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(BosTau_GirCam_filtered_chrX, file="./BosTau_GirCam_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i BosTau_GirCam_filtered_chrY.paf",
                         "-o BosTau_GirCam_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i BosTau_GirCam_filtered_chrX.paf",
                         "-o BosTau_GirCam_chrX_dotplot",
                         "-m 1000",
                         "-q 1000",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

#### MonMon #### 
BosTau_MonMon <- read_paf("BosTau_MonMon_chrX+Y_aln.paf")
BosTau_MonMon_filtered <- filter_secondary_alignments(BosTau_MonMon, remove_inversions=FALSE)
BosTau_MonMon_filtered_chrY <- subset(BosTau_MonMon_filtered, tname=="CM011803.1" & nmatch >= 500 & alen >= 500 & mapq >= 35)
BosTau_MonMon_filtered_chrX <- subset(BosTau_MonMon_filtered, tname=="CM011833.1" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(BosTau_MonMon_filtered_chrY, file="./BosTau_MonMon_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(BosTau_MonMon_filtered_chrX, file="./BosTau_MonMon_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i BosTau_MonMon_filtered_chrY.paf",
                         "-o BosTau_MonMon_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i BosTau_MonMon_filtered_chrX.paf",
                         "-o BosTau_MonMon_chrX_dotplot",
                         "-m 1000",
                         "-q 1000",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)
#### TraJav ####
BosTau_TraJav <- read_paf("BosTau_TraJav_chrX+Y_aln.paf")
BosTau_TraJav_filtered <- filter_secondary_alignments(BosTau_TraJav, remove_inversions=FALSE)
BosTau_TraJav_filtered_chrY <- subset(BosTau_TraJav_filtered, tname=="CM011803.1" & nmatch >= 500 & alen >= 500 & mapq >= 35)
BosTau_TraJav_filtered_chrX <- subset(BosTau_TraJav_filtered, tname=="CM011833.1" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(BosTau_TraJav_filtered_chrY, file="./BosTau_TraJav_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(BosTau_TraJav_filtered_chrX, file="./BosTau_TraJav_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i BosTau_TraJav_filtered_chrY.paf",
                         "-o BosTau_TraJav_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i BosTau_TraJav_filtered_chrX.paf",
                         "-o BosTau_TraJav_chrX_dotplot",
                         "-m 1000",
                         "-q 1000",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)



#################

#### ALIGNMENTS TO DOG
#### AilFul ####
CanLup_AilFul <- read_paf("CanLup_AilFul_chrX+Y_aln.paf")
CanLup_AilFul_filtered <- filter_secondary_alignments(CanLup_AilFul, remove_inversions=FALSE)
CanLup_AilFul_filtered_chrY <- subset(CanLup_AilFul_filtered, 
                                      tname %in% c("JAAUVH010000259.1", "JAAUVH010000289.1", "CM025139.1") & 
                                        nmatch >= 500 & alen >= 500 & mapq >= 35)
CanLup_AilFul_filtered_chrX <- subset(CanLup_AilFul_filtered, tname=="CM025138.1" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(CanLup_AilFul_filtered_chrY, file="./CanLup_AilFul_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(CanLup_AilFul_filtered_chrX, file="./CanLup_AilFul_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i CanLup_AilFul_filtered_chrY.paf",
                         "-o CanLup_AilFul_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i CanLup_AilFul_filtered_chrX.paf",
                         "-o CanLup_AilFul_chrX_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

#### OdoRos ####
CanLup_OdoRos <- read_paf("CanLup_OdoRos_chrX+Y_aln.paf")
CanLup_OdoRos_filtered <- filter_secondary_alignments(CanLup_OdoRos, remove_inversions=FALSE)
CanLup_OdoRos_filtered_chrY <- subset(CanLup_OdoRos_filtered, 
                                      tname %in% c("JAAUVH010000259.1", "JAAUVH010000289.1", "CM025139.1") & 
                                        nmatch >= 500 & alen >= 500 & mapq >= 35)
CanLup_OdoRos_filtered_chrX <- subset(CanLup_OdoRos_filtered, tname=="CM025138.1" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(CanLup_OdoRos_filtered_chrY, file="./CanLup_OdoRos_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(CanLup_OdoRos_filtered_chrX, file="./CanLup_OdoRos_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i CanLup_OdoRos_filtered_chrY.paf",
                         "-o CanLup_OdoRos_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i CanLup_OdoRos_filtered_chrX.paf",
                         "-o CanLup_OdoRos_chrX_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)


#################

#### ALIGNMENTS TO TADBRA
#### HipPen ####
TadBra_HipPen <- read_paf("TadBra_HipPen_chrX+Y_aln.paf")
TadBra_HipPen_filtered <- filter_secondary_alignments(TadBra_HipPen, remove_inversions=FALSE)
TadBra_HipPen_filtered_chrY <- subset(TadBra_HipPen_filtered, tname=="CM061281.1" & nmatch >= 500 & alen >= 500 & mapq >= 35)
TadBra_HipPen_filtered_chrX <- subset(TadBra_HipPen_filtered, tname=="CM061280.1" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(TadBra_HipPen_filtered_chrY, file="./TadBra_HipPen_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(TadBra_HipPen_filtered_chrX, file="./TadBra_HipPen_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i TadBra_HipPen_filtered_chrY.paf",
                         "-o TadBra_HipPen_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i TadBra_HipPen_filtered_chrX.paf",
                         "-o TadBra_HipPen_chrX_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

#### PteAle ####
TadBra_PteAle <- read_paf("TadBra_PteAle_chrX+Y_aln.paf")
TadBra_PteAle_filtered <- filter_secondary_alignments(TadBra_PteAle, remove_inversions=FALSE)
TadBra_PteAle_filtered_chrY <- subset(TadBra_PteAle_filtered, tname=="CM061281.1" & nmatch >= 500 & alen >= 500 & mapq >= 35)
TadBra_PteAle_filtered_chrX <- subset(TadBra_PteAle_filtered, tname=="CM061280.1" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(TadBra_PteAle_filtered_chrY, file="./TadBra_PteAle_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(TadBra_PteAle_filtered_chrX, file="./TadBra_PteAle_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i TadBra_PteAle_filtered_chrY.paf",
                         "-o TadBra_PteAle_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i TadBra_PteAle_filtered_chrX.paf",
                         "-o TadBra_PteAle_chrX_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)



#################

#### ALIGNMENTS TO VESMUR
#### PhyDis ####
VesMur_PhyDis <- read_paf("VesMur_PhyDis_chrX+Y_aln.paf")
VesMur_PhyDis_filtered <- filter_secondary_alignments(VesMur_PhyDis, remove_inversions=FALSE)
VesMur_PhyDis_filtered_chrY <- subset(VesMur_PhyDis_filtered, tname=="OZ004723.1" & nmatch >= 500 & alen >= 500 & mapq >= 35)
VesMur_PhyDis_filtered_chrX <- subset(VesMur_PhyDis_filtered, tname=="OZ004710.1" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(VesMur_PhyDis_filtered_chrY, file="./VesMur_PhyDis_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(VesMur_PhyDis_filtered_chrX, file="./VesMur_PhyDis_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i VesMur_PhyDis_filtered_chrY.paf",
                         "-o VesMur_PhyDis_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i VesMur_PhyDis_filtered_chrX.paf",
                         "-o VesMur_PhyDis_chrX_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)





#################

#### ALIGNMENTS TO LION
#### CryFer ####
PanLeo_CryFer <- read_paf("PanLeo_CryFer_chrX+Y_aln.paf")
PanLeo_CryFer_filtered <- filter_secondary_alignments(PanLeo_CryFer, remove_inversions=FALSE)
PanLeo_CryFer_filtered_chrY <- subset(PanLeo_CryFer_filtered, 
                                      tname %in% c("CM031449.1", "JAEQMX010000085.1", "JAEQMX010000086.1", "JAEQMX010000087.1", "JAEQMX010000088.1", "JAEQMX010000089.1", "JAEQMX010000090.1",
                                                   "JAEQMX010000091.1", "JAEQMX010000092.1", "JAEQMX010000093.1", "JAEQMX010000094.1", "JAEQMX010000095.1", "JAEQMX010000096.1", 
                                                   "JAEQMX010000097.1", "JAEQMX010000098.1") & nmatch >= 500 & alen >= 500 & mapq >= 35)
PanLeo_CryFer_filtered_chrX <- subset(PanLeo_CryFer_filtered, tname=="CM031430.1" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(PanLeo_CryFer_filtered_chrY, file="./PanLeo_CryFer_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(PanLeo_CryFer_filtered_chrX, file="./PanLeo_CryFer_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i PanLeo_CryFer_filtered_chrY.paf",
                         "-o PanLeo_CryFer_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i PanLeo_CryFer_filtered_chrX.paf",
                         "-o PanLeo_CryFer_chrX_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

#### HipPen ####
PanLeo_HipPen <- read_paf("PanLeo_HipPen_chrX+Y_aln.paf")
PanLeo_HipPen_filtered <- filter_secondary_alignments(PanLeo_HipPen, remove_inversions=FALSE)
PanLeo_HipPen_filtered_chrY <- subset(PanLeo_HipPen_filtered, 
                                      tname %in% c("CM031449.1", "JAEQMX010000085.1", "JAEQMX010000086.1", "JAEQMX010000087.1", "JAEQMX010000088.1", "JAEQMX010000089.1", "JAEQMX010000090.1",
                                                   "JAEQMX010000091.1", "JAEQMX010000092.1", "JAEQMX010000093.1", "JAEQMX010000094.1", "JAEQMX010000095.1", "JAEQMX010000096.1", 
                                                   "JAEQMX010000097.1", "JAEQMX010000098.1") & nmatch >= 500 & alen >= 500 & mapq >= 35)
PanLeo_HipPen_filtered_chrX <- subset(PanLeo_HipPen_filtered, tname=="CM031430.1" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(PanLeo_HipPen_filtered_chrY, file="./PanLeo_HipPen_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(PanLeo_HipPen_filtered_chrX, file="./PanLeo_HipPen_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i PanLeo_HipPen_filtered_chrY.paf",
                         "-o PanLeo_HipPen_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i PanLeo_HipPen_filtered_chrX.paf",
                         "-o PanLeo_HipPen_chrX_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

#### PteAle ####
PanLeo_PteAle <- read_paf("PanLeo_PteAle_chrX+Y_aln.paf")
PanLeo_PteAle_filtered <- filter_secondary_alignments(PanLeo_PteAle, remove_inversions=FALSE)
PanLeo_PteAle_filtered_chrY <- subset(PanLeo_PteAle_filtered, 
                                      tname %in% c("CM031449.1", "JAEQMX010000085.1", "JAEQMX010000086.1", "JAEQMX010000087.1", "JAEQMX010000088.1", "JAEQMX010000089.1", "JAEQMX010000090.1",
                                                   "JAEQMX010000091.1", "JAEQMX010000092.1", "JAEQMX010000093.1", "JAEQMX010000094.1", "JAEQMX010000095.1", "JAEQMX010000096.1", 
                                                   "JAEQMX010000097.1", "JAEQMX010000098.1") & nmatch >= 500 & alen >= 500 & mapq >= 35)
PanLeo_PteAle_filtered_chrX <- subset(PanLeo_PteAle_filtered, tname=="CM031430.1" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(PanLeo_PteAle_filtered_chrY, file="./PanLeo_PteAle_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(PanLeo_PteAle_filtered_chrX, file="./PanLeo_PteAle_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i PanLeo_PteAle_filtered_chrY.paf",
                         "-o PanLeo_PteAle_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i PanLeo_PteAle_filtered_chrX.paf",
                         "-o PanLeo_PteAle_chrX_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

#### SolPar ####
PanLeo_SolPar <- read_paf("PanLeo_SolPar_chrX+Y_aln.paf")
PanLeo_SolPar_filtered <- filter_secondary_alignments(PanLeo_SolPar, remove_inversions=FALSE)
PanLeo_SolPar_filtered_chrY <- subset(PanLeo_SolPar_filtered, 
                                      tname %in% c("CM031449.1", "JAEQMX010000085.1", "JAEQMX010000086.1", "JAEQMX010000087.1", "JAEQMX010000088.1", "JAEQMX010000089.1", "JAEQMX010000090.1",
                                                   "JAEQMX010000091.1", "JAEQMX010000092.1", "JAEQMX010000093.1", "JAEQMX010000094.1", "JAEQMX010000095.1", "JAEQMX010000096.1", 
                                                   "JAEQMX010000097.1", "JAEQMX010000098.1") & nmatch >= 500 & alen >= 500 & mapq >= 35)
PanLeo_SolPar_filtered_chrX <- subset(PanLeo_SolPar_filtered, tname=="CM031430.1" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(PanLeo_SolPar_filtered_chrY, file="./PanLeo_SolPar_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(PanLeo_SolPar_filtered_chrX, file="./PanLeo_SolPar_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i PanLeo_SolPar_filtered_chrY.paf",
                         "-o PanLeo_SolPar_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i PanLeo_SolPar_filtered_chrX.paf",
                         "-o PanLeo_SolPar_chrX_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)
#### PhyDis ####
PanLeo_PhyDis <- read_paf("PanLeo_PhyDis_chrX+Y_aln.paf")
PanLeo_PhyDis_filtered <- filter_secondary_alignments(PanLeo_PhyDis, remove_inversions=FALSE)
PanLeo_PhyDis_filtered_chrY <- subset(PanLeo_PhyDis_filtered, 
                                      tname %in% c("CM031449.1", "JAEQMX010000085.1", "JAEQMX010000086.1", "JAEQMX010000087.1", "JAEQMX010000088.1", "JAEQMX010000089.1", "JAEQMX010000090.1",
                                                   "JAEQMX010000091.1", "JAEQMX010000092.1", "JAEQMX010000093.1", "JAEQMX010000094.1", "JAEQMX010000095.1", "JAEQMX010000096.1", 
                                                   "JAEQMX010000097.1", "JAEQMX010000098.1") & nmatch >= 500 & alen >= 500 & mapq >= 35)
PanLeo_PhyDis_filtered_chrX <- subset(PanLeo_PhyDis_filtered, tname=="CM031430.1" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(PanLeo_PhyDis_filtered_chrY, file="./PanLeo_PhyDis_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(PanLeo_PhyDis_filtered_chrX, file="./PanLeo_PhyDis_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i PanLeo_PhyDis_filtered_chrY.paf",
                         "-o PanLeo_PhyDis_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i PanLeo_PhyDis_filtered_chrX.paf",
                         "-o PanLeo_PhyDis_chrX_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)



#### MunMun ####
PanLeo_MunMun <- read_paf("PanLeo_MunMun_chrX+Y_aln.paf")
PanLeo_MunMun_filtered <- filter_secondary_alignments(PanLeo_MunMun, remove_inversions=FALSE)
PanLeo_MunMun_filtered_chrY <- subset(PanLeo_MunMun_filtered, 
                                      tname %in% c("CM031449.1", "JAEQMX010000085.1", "JAEQMX010000086.1", "JAEQMX010000087.1", "JAEQMX010000088.1", "JAEQMX010000089.1", "JAEQMX010000090.1",
                                                   "JAEQMX010000091.1", "JAEQMX010000092.1", "JAEQMX010000093.1", "JAEQMX010000094.1", "JAEQMX010000095.1", "JAEQMX010000096.1", 
                                                   "JAEQMX010000097.1", "JAEQMX010000098.1") & nmatch >= 500 & alen >= 500 & mapq >= 35)
PanLeo_MunMun_filtered_chrX <- subset(PanLeo_MunMun_filtered, tname=="CM031430.1" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(PanLeo_MunMun_filtered_chrY, file="./PanLeo_MunMun_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(PanLeo_MunMun_filtered_chrX, file="./PanLeo_MunMun_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i PanLeo_MunMun_filtered_chrY.paf",
                         "-o PanLeo_MunMun_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i PanLeo_MunMun_filtered_chrX.paf",
                         "-o PanLeo_MunMun_chrX_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

#################

#### ALIGNMENTS TO SHREW
#### SolPar ####
SunEtr_SolPar <- read_paf("SunEtr_SolPar_chrX+Y_aln.paf")
SunEtr_SolPar_filtered <- filter_secondary_alignments(SunEtr_SolPar, remove_inversions=FALSE)
SunEtr_SolPar_filtered_chrY <- subset(SunEtr_SolPar_filtered, 
                                      tname %in% c("CM043993.1", "JAMYDX010000015.1", "JAMYDX010000023.1", "JAMYDX010000017.1") & 
                                        nmatch >= 500 & alen >= 500 & mapq >= 35)
SunEtr_SolPar_filtered_chrX <- subset(SunEtr_SolPar_filtered, tname %in% c("CM043992.1", "JAMYDX010000040.1", "JAMYDX010000022.1", "JAMYDX010000041.1", "JAMYDX010000016.1", "JAMYDX010000042.1", "JAMYDX010000036.1", "JAMYDX010000035.1", "JAMYDX010000029.1", 
                                                                           "JAMYDX010000019.1", "JAMYDX010000018.1", "JAMYDX010000032.1","JAMYDX010000034.1", "JAMYDX010000021.1", "JAMYDX010000020.1", "JAMYDX010000043.1", "JAMYDX010000039.1", 
                                                                           "JAMYDX010000033.1", "JAMYDX010000031.1", "JAMYDX010000030.1", "JAMYDX010000028.1", "JAMYDX010000027.1", "JAMYDX010000026.1", "JAMYDX010000025.1", "JAMYDX010000037.1", 
                                                                           "JAMYDX010000024.1", "JAMYDX010000038.1") & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(SunEtr_SolPar_filtered_chrY, file="./SunEtr_SolPar_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(SunEtr_SolPar_filtered_chrX, file="./SunEtr_SolPar_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i SunEtr_SolPar_filtered_chrY.paf",
                         "-o SunEtr_SolPar_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i SunEtr_SolPar_filtered_chrX.paf",
                         "-o SunEtr_SolPar_chrX_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)



#################

#### ALIGNMENTS TO HORSE
#### TapTer ####
EquCab_TapTer <- read_paf("EquCab_TapTer_chrX+Y_aln.paf")
EquCab_TapTer_filtered <- filter_secondary_alignments(EquCab_TapTer, remove_inversions=FALSE)
EquCab_TapTer_filtered_chrY <- subset(EquCab_TapTer_filtered, tname=="MH341179.1" & nmatch >= 500 & alen >= 500 & mapq >= 35)
EquCab_TapTer_filtered_chrX <- subset(EquCab_TapTer_filtered, tname=="CM071564.1" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(EquCab_TapTer_filtered_chrY, file="./EquCab_TapTer_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(EquCab_TapTer_filtered_chrX, file="./EquCab_TapTer_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i EquCab_TapTer_filtered_chrY.paf",
                         "-o EquCab_TapTer_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i EquCab_TapTer_filtered_chrX.paf",
                         "-o EquCab_TapTer_chrX_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

#### ALIGNMENTS TO RHINO
#### SolPar ####
CerSim_SolPar <- read_paf("CerSim_SolPar_chrX+Y_aln.paf")
CerSim_SolPar_filtered <- filter_secondary_alignments(CerSim_SolPar, remove_inversions=FALSE)
CerSim_SolPar_filtered_chrY <- subset(CerSim_SolPar_filtered, tname=="CM043850.1" & nmatch >= 200 & alen >= 200 & mapq >= 35)
CerSim_SolPar_filtered_chrX <- subset(CerSim_SolPar_filtered, tname=="CM043849.1" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(CerSim_SolPar_filtered_chrY, file="./CerSim_SolPar_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(CerSim_SolPar_filtered_chrX, file="./CerSim_SolPar_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i CerSim_SolPar_filtered_chrY.paf",
                         "-o CerSim_SolPar_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i CerSim_SolPar_filtered_chrX.paf",
                         "-o CerSim_SolPar_chrX_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)
#### TapTer ####
CerSim_TapTer <- read_paf("CerSim_TapTer_chrX+Y_aln.paf")
CerSim_TapTer_filtered <- filter_secondary_alignments(CerSim_TapTer, remove_inversions=FALSE)
CerSim_TapTer_filtered_chrY <- subset(CerSim_TapTer_filtered, tname=="CM043850.1" & nmatch >= 200 & alen >= 200 & mapq >= 35)
CerSim_TapTer_filtered_chrX <- subset(CerSim_TapTer_filtered, tname=="CM043849.1" & nmatch >= 1000 & alen >= 1000 & mapq >= 35)

# write alignments to new paf file
write.table(CerSim_TapTer_filtered_chrY, file="./CerSim_TapTer_filtered_chrY.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

write.table(CerSim_TapTer_filtered_chrX, file="./CerSim_TapTer_filtered_chrX.paf",             
            sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# generate dotplots for X and Y chromosomes
DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i CerSim_TapTer_filtered_chrY.paf",
                         "-o CerSim_TapTer_chrY_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

DotPlotly_lines <- paste("Rscript",
                         "mod_pafCoordsDotPlotly.R",
                         "-i CerSim_TapTer_filtered_chrX.paf",
                         "-o CerSim_TapTer_chrX_dotplot",
                         "-m 500",
                         "-q 500",
                         "-s",
                         "-l",
                         "-t",
                         "-p 7.5")
system(DotPlotly_lines)

