# README for /data-collection/

*Scripts are listed in the order of their usage.*

#### 1. CDS_from_ncbiEntrez.py
This script uses the NCBI Entrez tool to download coding sequences from a specified genome.

#### 2. ncbi_genome_download.slurm
This script downloads genomes from NCBI.

#### 3. extract_regions_from_fasta.py
This script extracts specified regions from a FASTA file and stores them into a new FASTA file (i.e., you can specified genes and their start-end positions, 

#### 4. remove_regions_from_fasta.py
This script was written to remove user-specified regions from a FASTA file. The intention behind this script was to enable users to remove any pseudogenes of certain genes from a chromosome, such as the multiple pseudogenes of USP9Y in _Homo sapiens_' Y chromosome.
