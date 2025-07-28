# phylogen-Y

This repository houses the code used to generate and analyze data for the manuscript, "The Y-chromosome is a reliable marker for deep-time phylogenetic inference."

### Getting started
Each folder contains a README that states the purpose of the script(s). Folders are named after their respective section in the manuscript's methods:
* [data collection](https://github.com/emistasis/phylogen-y/tree/main/data-collection)
* [sex-linked sequence identification](https://github.com/emistasis/phylogen-y/tree/main/sex-linked)
* [alignments](https://github.com/emistasis/phylogen-y/tree/main/alignment-generation)
* [measuring evolutionary conservation of sites](https://github.com/emistasis/phylogen-y/tree/main/evolutionary-conservation)
* [phylogenetic reconstruction](https://github.com/emistasis/phylogen-y/tree/main/phylogenies)
* [alternative tree topology test](https://github.com/emistasis/phylogen-y/tree/main/topology_tests)
* [identification of gene conversion](https://github.com/emistasis/phylogen-y/tree/main/gene-conversion)

### Dependencies
The majority of these scripts use basic Python packages (argparse, os) and R packages). Most scripts do not require special dependencies or installation instructions. I do not provide Conda environment files for most scripts, but dependencies are clearly listed at the start of the code.

All code was ran on a personal MacOS Sonoma or the [Texas A&M HPRC cluster](https://hprc.tamu.edu). I do provide some SLURM job scripts.

### Citation
If you use any of this code, please cite the following paper:

Alexander, E.P., Foley, N.M., and Murphy, W.J. In Review. "Using the mammalian Y-chromosome for deep-time phylogenetic inference."
 
### Support
If you need assistance with navigating this repository, running any of these scripts, or just general questions, please don't hesitate to reach out via [email](emmarie.alexander@tamu.edu) or create an issue.
