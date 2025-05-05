# phylogen-Y: using the Y-chromosome for deep-time phylogenetics

This repository houses almost all of the code I used to generate and analyze data for the manuscript, "The Y-chromosome is a reliable marker for deep-time phylogenetic inference."

### Getting started
Each folder contains a README that states the purpose of each script.

The repository itself is sorted into multiple folders, with each folder named after a main method in the paper:
* data collection
* de novo sex-linked sequence identification
* alignment generation
* measuring evolutionary conservation of sites
* assessing variation in substitution rates between sex chromosomes
* identifying gene conversion events

### Dependencies
The majority of these scripts use basic python packages (argparse, os) and R packages. Most scripts do not require any special dependencies or walkthroughs on how to install necessary packages. I do not provide Conda environment files for most scripts, but dependencies are clearly listed at the start of the code.

All code was written ran on a personal MacOS Sonomoa or the [Texas A&M HPRC cluster](https://hprc.tamu.edu).

### Citation
If you use any of this code, please cite the following paper:

Alexander, E.P., Foley, N.M., and Murphy, W.J. In Progress. "Using the mammalian Y-chromosome for deep-time phylogenetic inference."
 
### Support

If you need assistance with navigating this repository, using any of these scripts, or just general questions, please don't hesitate to reach out via [email](emmarie.alexander@tamu.edu) or create an issue.

