# README for /evolutionary-conservation/

*Scripts are listed in the order of their usage.*

#### 1. gap_remover_phyloP.py
This script removes any gaps present in the reference species' Y chromosome so that you can generate per-base phyloP scores.

#### 2. phyloP_FASTA_annotator.py
This script allows users to annotate their FASTA file with phyloP scores and then filter sites based on a user provided threshold to create a new FASTA file. I've attached the phyloP_env.yml file which can be used to import the necessary environment.

#### 3. alignment_statistics_barchart.R
This is the R code written to generate the barchart for the alignments.
