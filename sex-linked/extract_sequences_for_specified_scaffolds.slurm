#!/bin/bash
##NECESSARY JOB SPECIFICATIONS

#SBATCH --export=NONE  
#SBATCH --job-name=extract_sequences_for_specified_scaffolds
#SBATCH --time=00:30:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=180G
#SBATCH --output=%x.out.%j
#SBATCH --error=%x.err.%j

##################### SYNOPSIS #####################
# This script is used to extract sequences in FASTA format using seqkit.
# It works be running SeqKit. SeqKit scans a text file containing FASTA sequence headers (e.g., "LNAC01000989.1") and will extract the respective sequence from the genome file, outputting it into a new FASTA.

##################### LOAD #####################
module load SeqKit/0.16.0

##################### INPUTS ######################
# Path to text file containing scaffolds that were identified as putatively Y-linked
AilFul_wm='/scratch/user/emmarie.alexander/comprehensive_cactus_Y/RepeatMasker/cactus_run8_genomes/AilFul_chrY_scaffolds_toExtract.txt'

# Path to genome FASTA file
AilFul_genome='./AilFul_GCA_002007465.1_unplacedScaf.fna'

seqkit grep -f $AilFul_wm $AilFul_genome > AilFul_wm_chrY_scafs.fasta

#########################################################################################
	<<CITATIONS
	
    - Acknowledge TAMU HPRC: https://hprc.tamu.edu/research/citations.html

	
    - seqkit (https://bioinf.shenwei.me/seqkit/)

	
CITATIONS
