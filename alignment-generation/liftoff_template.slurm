#!/bin/bash

##NECESSARY JOB SPECIFICATIONS
#SBATCH --job-name=LiftOff
#SBATCH --time=1-00:00:00             		
#SBATCH --ntasks=4
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=360G
#SBATCH --error=%x.err.%j 
#SBATCH --mail-type=ALL              
#SBATCH --mail-user=emmarie.alexander@tamu.edu 


module load Anaconda3/2023.07-2

source /sw/eb/sw/Anaconda3/2023.07-2/bin/activate
conda activate /user/path/.conda/envs/Liftoff-1.6.3

cd  /user/path/emmarie.alexander/cactus/liftoff

liftoff -p 32 -g HomSap_T2T_RefSeqAnnotations.GFF3 -o HomSap_Cactus_Run11_Annotated.GFF3 HomSap_run11_chrY_fullLength.fasta HomSap_T2T_chrY_masked.fna
# -p is necessary to parallelize the process, you can multiple the number of tasks (--ntasks 4) by the number of cpus per task (--cpus-per-task 8; 4 * 8 = 32) to get the number that you set for -p

<< CITATIONS
  - Shumate, Alaina, and Steven L. Salzberg. 2020. “Liftoff: Accurate Mapping of Gene Annotations.” Bioinformatics , December. https://doi.org/10.1093/bioinformatics/btaa1016.
CITATIONS
