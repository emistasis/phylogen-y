#!/bin/bash

##NECESSARY JOB SPECIFICATIONS
#SBATCH --job-name=BLAST_winnowmap
#SBATCH --time=10:00:00             		
#SBATCH --ntasks=1   
#SBATCH --ntasks-per-node=16              
#SBATCH --mem=16G                    
#SBATCH --output=%x.out.%j
#SBATCH --error=%x.err.%j  

module load GCC/11.3.0  OpenMPI/4.1.4
module load BLAST+/2.13.0

# this command creates a NCBI BLAST database out of the genome assembly
makeblastdb -in RefGenome_chrY_mRNAseqs.fasta -dbtype nucl -out database

# the TargetGenome_winnowmap_chrY_hits.fna is created using seqkit.
blastn -task dc-megablast -db database -max_target_seqs 10 -use_index true \
    -query TargetGenome_winnowmap_chrY_hits.fna -evalue 1e-50 -perc_identity 60 \
        -outfmt "6 qseqid sseqid stitle pident length mismatch gapopen qstart qend sstart send evalue bitscore sseq" \
        -out TargetGenome_winnowmap_hits_BLAST.txt
