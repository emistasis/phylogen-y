#!/bin/bash

#SBATCH --job-name=HRA_all_topology_tests
#SBATCH --time=2-00:00:00
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=3
#SBATCH --mem=180G
#SBATCH --output=stdout.%x.%j
#SBATCH --error=stderr.%x.%j

module load GCC/11.3.0 OpenMPI/4.1.4 IQ-TREE/2.2.2.3

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

cd ./HRA_alternative_topology_tests

tamulauncher --norestart HRA_alternative_topology_tests.in

<<README
## ===================================SYNOPSIS=========================================
## This script is used to run alternative topology tests.
README

<<CITATIONS
    - Acknowledge TAMU HPRC: https://hprc.tamu.edu/research/citations.html
CITATIONS
