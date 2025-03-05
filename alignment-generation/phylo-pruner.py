# Title: phylo_pruner.py
# Author: Emmarie Alexander
# Email: emmarie.alexander@tamu.edu
# Date written: 5-Oct-2023
# Date last updated: 28-May-2024

## ===================================README=========================================
# This script was originally written to prune the Zoonomia 241-mammal phylogeny published by Foley et al. (2023). 
# The script extracts taxa (or closely related taxa) and will be used as the guide tree for my Progressive Cactus alignment. 
# This script preserves both internal and terminal branch lengths.

from ete3 import Tree

# Specify your starting tree - in this case, I'm using Foley's Zoonomia tree that was constructed from neutral sites scross the whole-genome and referenced to the human
tree = Tree("/user/path/Concatenation_HRA_neutral_241_10miss_rooted.tr")

taxa_to_keep = []

# Replace the text file with a file that contains the names of the species you want to extract from the phylogeny, make sure species names are identical to the tree you're extracting from.
with open("/user/path/species_to_extract.txt","r") as taxa_file:
    for line in taxa_file:
        taxa_to_keep.append(line.strip())

# Create a list of nodes to prune
nodes_to_prune = []

for leaf in tree:
    if leaf.name not in taxa_to_keep:
        nodes_to_prune.append(leaf)

# Prune the specified nodes
for node in nodes_to_prune:
    node.delete(preserve_branch_length=True) # you can set preserve_branch_length to false if you're not interesting in maintaining branch lengths, but that shouldn't be necessary

outfile = "guideTree.tr"  # Make sure to rename your output tree!

# outputs the pruned tree
tree.write(outfile=outfile, format=1) # you can change the format depending on what you're interested in. if you want to retain bootstrap values, change format = 0. if you just want branch lengths, change to format = 1

# Print when completed
print(f"Pruned tree with preserved branch lengths saved to {outfile}")
