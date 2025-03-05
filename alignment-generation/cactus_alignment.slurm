#!/bin/bash
##NECESSARY JOB SPECIFICATIONS
#SBATCH --export=NONE  
#SBATCH --job-name=progressive_cactus
#SBATCH --time=4-00:00:00
#SBATCH --ntasks-per-node=6
#SBATCH --cpus-per-task=3
#SBATCH --mem-per-cpu=8GB
#SBATCH --output=%x.out.%j
#SBATCH --error=%x.err.%j
#SBATCH --mail-type=ALL

module load WebProxy
export SINGULARITY_CACHEDIR=$SCRATCH/.singularity

# Download cactus img file to run if not already downloaded in current directory...
if [[ ! -f cactus.img ]]
then
    singularity pull cactus.img docker://quay.io/comparative-genomics-toolkit/cactus:v2.8.2
fi

# Run cactus (i.e. change --help to the cactus command you plan to run!)
singularity exec cactus.img cactus ./jobstore input.txt alignment.hal --consCores 1

<<CITATIONS
	  - TAMU HPRC: https://hprc.tamu.edu/research/citations.html
	  - Progressive Cactus: https://github.com/ComparativeGenomicsToolkit/cactus
		- Updating Cactus alignments: https://github.com/ComparativeGenomicsToolkit/cactus/blob/master/doc/updating-alignments.md
		- cactus-update-prepare: https://github.com/ComparativeGenomicsToolkit/cactus/blob/master/doc/cactus-update-prepare.md
CITATIONS
