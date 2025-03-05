#!/bin/bash
##NECESSARY JOB SPECIFICATIONS
#SBATCH --export=NONE  
#SBATCH --job-name=winnowmap
#SBATCH --time=10:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=180G
#SBATCH --output=%x.out.%j
#SBATCH --error=%x.err.%j
##SBATCH --mail-type=BEGIN,FAIL,END

##################### SYNOPSIS #####################
# This script will generate Winnowmap alignments for scaffold-level genomes of species that do not have assembled Y chromosomes
# to closely related, slowly evolving species that have an assembled Y chromosome.

##################### LOAD #####################
module load Anaconda3/2023.07-2
source activate Winnowmap2.03

 ################################################################################### VARIABLES ##################################################################################
# TODO Edit these variables as needed:

###################### INPUTS ######################
### Reference Genomes ###
EquCab='/user/path/EquCab_GCA_036426135.1_chrX_MH341179_chrY.fna'
# this reference genome contains both the X and Y chromosomes

### Target Genomes ###
TapTer='/user/path/TapTer_GCA_028533255.1_unplacedScafs.fna'
# this target genome only contains any unplaced scaffolds as the rest of the genome is assembled to chromosome-level

### WINNOWMAP ####
meryl count k=19 output EquCab_merylDB $EquCab
meryl print greater-than distinct=0.9998 EquCab_merylDB > EquCab_chrX+Y_repetitive_k19.txt

winnowmap -W EquCab_chrX+Y_repetitive_k19.txt -ax asm20 $EquCab $TapTer > EquCab_TapTer_chrX+Y_aln.sam

##################### UNLOAD #####################
source deactivate

<< CITATIONS
  Chirag Jain, Arang Rhie, Nancy Hansen, Sergey Koren and Adam Phillippy. "Long-read mapping to repetitive reference sequences using Winnowmap2". Nature Methods, 2022.
  Chirag Jain, Arang Rhie, Haowen Zhang, Chaudia Chu, Brian Walenz, Sergey Koren and Adam Phillippy. "Weighted minimizer sampling improves long read mapping". Bioinformatics (ISMB proceedings), 2020.
CITATIONS
