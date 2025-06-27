# README for /gene-conversion/

*Scripts are listed in the order of their usage.*

#### 1. geneTree_concatenator.py
This script can be used to concatenate or merge two (gene) trees into a single tree.

#### 2. automated_window_sliding_template.slurm
SLURM template to run a sliding window analysis using [Automated-Window-Sliding](https://github.com/ggruber193/automated-window-sliding) on a HPC cluster

#### 3. arborist_find_extract_clean.py
Since we used GHOST as our sequence model for the sliding window analysis, each alignment window had a .treefile outputted that contained five trees - the consensus tree with an additional four trees per base parameter. This script will extract the consensus tree (the first line) from each window's .treefile.

#### 4. treeFile_merger.py
This script merges multiple IQ-TREE .treefiles in order to create a single .treefile that contains multiple trees from separate IQ-TREE runs. Basically, this script is helpful if you're trying to perform a constraint tree search. 

#### 5. topologyTest_resultsMiner.py
This script works to extract the topology test outputs from multiple .iqtree files after performing an alternative topology test.
