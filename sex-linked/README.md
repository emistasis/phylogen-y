# README for /sex-linked/

*Scripts are listed in the order of their usage.*

As outlined in the manuscript, we used a novel approach to identify Y-linked sequences in species without an assembled Y chromosome.
This figure outlines the general steps and tools needed to take:
<img width="2614" height="1543" alt="FigS1 SequenceIdentificationPipeline" src="https://github.com/user-attachments/assets/3ac17a7a-cce7-45ca-b207-061329c8cda1" />

#### 1. run_winnowmap.slurm
Used to perform the alignment of your query against the reference species.

#### 2. sam2paf.sh
Contains options for converting a SAM alignment file into a PAF using either bioconvert or minimap2.

#### 3. mod_pafCoordsDotPlotly.R & winnowmap_pafR_dotplotly.R
Winnowmap_pafR_dotplotly.R script uses the R package pafR to filter PAF alignments and generate dotplots. Because of the paucity of sequence alignment, I modified the pafRCoordsDotplotly.R file. In order for the filter and visualization script to work, you must either change the code or use the modified script.

#### 4. extract_sequences_for_specified_scaffolds.slurm
Used to extract sequences from a genome assembly using FASTA sequence headers.

#### 5. winnowmap_BLAST_verification.slurm
Creates a BLAST database then runs your desired sequences against the database, exporting them into an easy to read .txt file.

#### 5. MAFFT_IQTREE.slurm
After manually filtering the BLAST hits based on metrics (we used sequence mismatch, and e-values), we selected the most likely scaffolds containing hits for each single-copy MSY gene.
From there, we created a FASTA file containing all of the best hits and known MSY genes, align them using MAFFT, and generated gene trees using IQ-TREE.


