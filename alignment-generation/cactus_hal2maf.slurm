#!/bin/bash
##NECESSARY JOB SPECIFICATIONS
#SBATCH --export=NONE  
#SBATCH --job-name=cactus_hal2maf
#SBATCH --time=2-00:00:00
#SBATCH --ntasks=8
#SBATCH --ntasks-per-node=8
#SBATCH --mem-per-cpu=16GB
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

cd /user/path/cactus

# Run cactus (i.e. change --help to the cactus command you plan to run!)
singularity exec cactus.img cactus-hal2maf ./jobstore cactus_final.hal cactus_HomSap_ref_consensus.maf --coverage --refGenome Homo_sapiens --noAncestors --chunkSize 1000000 --filterGapCausingDupes --dupeMode consensus --batchCount 4 --batchCores 2 --batchMemory 16GB

singularity exec cactus.img cactus-hal2maf ./jobstore cactus_final.hal cactus_BosTau_ref_consensus.maf --coverage --refGenome Bos_taurus --noAncestors --chunkSize 1000000 --filterGapCausingDupes --dupeMode  consensus--batchCount 4 --batchCores 2 --batchMemory 16GB

