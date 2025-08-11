#!/bin/bash

#SBATCH --export=NONE
#SBATCH --get-user-env=L   

#SBATCH --job-name=tamulauncher_IQTREE
#SBATCH --time=2-00:00:00
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=2
#SBATCH --mem=180G
#SBATCH --output=stdout.%x.%j
#SBATCH --error=stderr.%x.%j

module load GCC/11.3.0 OpenMPI/4.1.4 IQ-TREE/2.2.2.3

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

cd ./IQTREE_trees

tamulauncher IQTREE-tamulauncher.in

<<README
## ===================================SYNOPSIS=========================================
## This script is used to generate Maximum Likelihood trees with 1000 ultrafast bootstrap replicates.
README

<<CITATIONS
    - Acknowledge TAMU HPRC: https://hprc.tamu.edu/research/citations.html

    - IQ-TREE: http://www.iqtree.org/
CITATIONS
