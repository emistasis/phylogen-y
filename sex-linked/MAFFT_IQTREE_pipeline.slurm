#!/bin/bash
##NECESSARY JOB SPECIFICATIONS

#SBATCH --export=NONE  
#SBATCH --job-name=MAFFT_IQTREE
#SBATCH --time=03:30:00
#SBATCH --ntasks=3
#SBATCH --cpus-per-task=24
#SBATCH --mem=180G
#SBATCH --output=%x.out.%j
#SBATCH --error=%x.err.%j
##SBATCH --mail-type=BEGIN,FAIL,END

##################### SYNOPSIS #####################
# This script will load in a list of sequence headers to search through genome files and extract the respective sequence for using seqkit.

##################### LOAD #####################
module load GCC/11.3.0 MAFFT/7.505-with-extensions

##################### MAFFT ####################
mafft --auto --adjustdirectionaccurately --inputorder input.fa > output_alignment

module purge

##################### IQ-TREE ##################
module load GCC/11.3.0  OpenMPI/4.1.4 IQ-TREE/2.2.2.3

iqtree2 -s output_alignment -m MFP -B 1000 -T AUTO

module purge
