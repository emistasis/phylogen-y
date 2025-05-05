#!/bin/bash

#SBATCH --job-name=AMS_template
#SBATCH --time=1-00:00:00
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=8
#SBATCH --mem=8G
#SBATCH --output=stdout.%x.%j
#SBATCH --error=stderr.%x.%j

module load Java/21.0.2 Nextflow/24.10.3 Anaconda3/2024.06-1 WebProxy/0000
 
nextflow run ggruber193/automated-window-sliding -profile conda \
	-c slurm_settings.config \
	--input \
	--outdir \
	--window_size 500 --step_size 50 \
	--run_mode "full"	\
	--output_windows true \
	--keep_tree_files true \
	--model "GTR*H4" \
	--phylo_parameters "-nt AUTO -m GTR*H4"
