# README for /alignment-generation/

*Scripts are listed in the order of their usage.*

#### 1.phylo-pruner.py
This python script is used to "prune" a pre-existing phylogeny and save only desired species and their branch lengths.

#### 2. cactus_alignment.slurm
This SLURM script was used to generate the Progressive Cactus alignment.

#### 3.cactus_add_branch.slurm
This SLURM script was used to add a new species, _Galeopterus variegatus_, to the Cactus alignment.

#### 4. cactus_hal2maf.slurm
This SLURM script was used to convert the original HAL alignment file into a MAF alignment.

#### 5. liftoff_template.slurm
This SLURM script uses the Liftoff program to annotate the reference species from the alignment using the Y-chromosome RefSeq annotations from NCBI.
