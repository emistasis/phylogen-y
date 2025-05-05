"""
Script title: tree_concatenator.py
Author: Emmarie Alexander
Contact: emmarie.alexander@tamu.edu
Date written: 05-February-2025
Date last updated: 5-May-2025
Purpose: The purpose of this script is to concatenate two trees (in the case of this script's utilization, the assumed species tree for mammals).

Version 2: Adjusted the script so that the verbiage is less confusing and that it uses genes instead of gametologs.

Resources:
https://evomics.org/wp-content/uploads/2019/01/ete_tutorial.pdf
"""
#### PART ONE - CREATING A TOY PHYLOGENY ####
from ete3 import Tree

def read_gene_tree(filename):
    with open(filename, 'r') as file:
        newick_tree = file.read()

    tree = Tree(newick_tree) # Converts to a readable ete3
    tree.convert_to_ultrametric(tree_length=None, strategy='balanced') # Makes the tree ultrametric
    return tree # Returns tree object

# creates a new root and concatenates both trees together
def create_merged_tree(tree_1, tree_2, output_file=None):
    new_root = Tree()
    new_root.add_child(tree_1)
    new_root.add_child(tree_2)

    # Converts the newly constructed tree into a rooted, ultrametric (or "cladogram" tree)
    new_root.convert_to_ultrametric(tree_length=None, strategy='balanced')

    # Writes the new tree as an output file if output file name is specified
    if output_file:
        with open(output_file, 'w') as file:
            file.write(new_root.write(format=1)) # Print the merged tree in Newick format

    return new_root # Returns the merged tree

# Initial tree
t1_gene_tree = ".tre" # input tree one
t2_gene_tree = ".tre" # input tree two

# Read in newick trees from file
tree_1 = read_gene_tree(t1_gene_tree)
tree_2 = read_gene_tree(t2_gene_tree)

output_file = ".tre" # output file, you'll use this in the next step

merged_tree = create_merged_tree(tree_1, tree_2, output_file)
print(merged_tree)

######################## STEP TWO - PRUNE SPECIES TIPS ######################## 
# Load the species list from a text file
def load_species_list(filename):
    with open(filename, 'r') as file:
        species = {line.strip() for line in file}
    return species
   
# Prune tree to retain only the species specified in the list
def prune_tree(tree_file, species_list, final_output_tree=None):
    # Load species names
    species_staying_in_tree = load_species_list(species_list)

    # Load tree
    tree = Tree(tree_file, format=1)

    # Gets names of all of the leaves and ignore any leaves or nodes without names
    named_leaves = {leaf.name for leaf in tree.get_leaves() if leaf.name is not None}

    # Determines whether the sppecies list and species tree match up
    species_staying_in_tree = species_staying_in_tree.intersection(named_leaves)

    if not species_staying_in_tree:
        raise ValueError("No matching species found in the tree!")

    # Removes species (or tips) that are not found in the species list
    tree.prune(species_staying_in_tree, preserve_branch_length=True)

    # Save pruned tree
    if final_output_tree:
        tree.write(outfile=final_output_tree)

    return tree

# input files
species_list = ".txt" # path to a text file containing a list of what species you want in your final tree
tree_file = ".tre" # path to the input tree
final_output_tree = ".tre" # path to what you want your final output tree to be

pruned_tree = prune_tree(tree_file, species_list, final_output_tree)
print(pruned_tree)
