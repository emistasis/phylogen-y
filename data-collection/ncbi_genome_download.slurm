#!/bin/bash

##NECESSARY JOB SPECIFICATIONS
#SBATCH --job-name=rodent_genomes      
#SBATCH --time=01:30:00               
#SBATCH --ntasks=1                    
#SBATCH --mem=2560M                    
#SBATCH --output=rodent_genomes.%j

# unload any modules to start with a clean environment
module purge

# load necessary modules
module load GCCcore/12.2.0 Python/3.10.8

# load conda environment "NCBI-genome-download"
source /user/ncbi_py/ncbi/bin/activate

# American beaver (Castor canadensis), RefSeq database with all coding sequences outputted
ncbi-genome-download --section refseq --formats cds-fasta --assembly-accessions GCF_001984765.1 vertebrate_mammalian
