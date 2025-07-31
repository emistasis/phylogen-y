#!/bin/bash

##NECESSARY JOB SPECIFICATIONS
#SBATCH --job-name=winnowmap_BLAST_verification
#SBATCH --time=10:00:00             		
#SBATCH --ntasks=1   
#SBATCH --ntasks-per-node=16              
#SBATCH --mem=16G                    
#SBATCH --output=%x.out.%j
#SBATCH --error=%x.err.%j

##################### SYNOPSIS #####################
# This script will create a BLAST database from an associated FASTA file. Scaffolds that were identified as putatively Y-linked (TargetGenome) will be BLAST'd against this database.

##################### MODULE LOAD #####################
module load GCC/11.3.0  OpenMPI/4.1.4
module load BLAST+/2.13.0

# this command creates a NCBI BLAST database out of the specified genome assembly
makeblastdb -in {RefGenome}_chrY_mRNA_seqs.fasta -dbtype nucl -out database

# this command runs BLAST
# to generate the query FASTA/FNA file, you can use the following script: extract_sequences_for_specified_scaffolds.sh
blastn -task dc-megablast -db database -max_target_seqs 10 -use_index true \
    -query {TargetGenome}_winnowmap_chrY_scafs.fna -evalue 1e-50 -perc_identity 60 \
        -outfmt "6 qseqid sseqid stitle pident length mismatch gapopen qstart qend sstart send evalue bitscore sseq" \
        -out {TargetGenome}_winnowmap_hits_BLAST.txt
