"""
Script title: ete3_tree_concatenator.py
Author: Emmarie Alexander
Contact: emmarie.alexander@tamu.edu
Date written: 05-February-2025
Date last updated: 18-February-2025
Purpose: The purpose of this script is to concatenate two trees (in the case of this script's utilization, the assumed species tree for mammals),
with one tree belonging to the X-chromosome and its genes, and the other tree belonging to the Y-chromosome and its genes.

Resources:
https://evomics.org/wp-content/uploads/2019/01/ete_tutorial.pdf
"""
#### PART ONE - CREATING A TOY PHYLOGENY ####
from ete3 import Tree

def read_gametolog_tree(filename):
    with open(filename, 'r') as file:
        newick_tree = file.read()

    tree = Tree(newick_tree) # Converts to a readable ete3
    tree.convert_to_ultrametric(tree_length=None, strategy='balanced') # Makes the tree ultrametric
    return tree # Returns tree object

# creates a new root and concatenates both trees together
def create_merged_tree(tree_X, tree_Y, output_file=None):
    new_root = Tree()
    new_root.add_child(tree_X)
    new_root.add_child(tree_Y)

    # Converts the newly constructed tree into a rooted, ultrametric (or "cladogram" tree)
    new_root.convert_to_ultrametric(tree_length=None, strategy='balanced')

    # Writes the new tree as an output file if output file name is specified
    if output_file:
        with open(output_file, 'w') as file:
            file.write(new_root.write(format=1)) # Print the merged tree in Newick format

    return new_root # Returns the merged tree

# Initial gametolog trees
X_gametolog_tree = "/Users/emmarie.alexander/Documents/GitHub/script_runner/ete3_tree_concatenator/BRA_Laurasiatheria_ZFX.tre"
Y_gametolog_tree = "/Users/emmarie.alexander/Documents/GitHub/script_runner/ete3_tree_concatenator/BRA_Laurasiatheria_ZFY.tre"

# Read in newick trees from file
tree_X = read_gametolog_tree(X_gametolog_tree)
tree_Y = read_gametolog_tree(Y_gametolog_tree)

output_file = "/Users/emmarie.alexander/Documents/GitHub/script_runner/ete3_tree_concatenator/Laurasiatheria_concatenated_ZFY_ZFX.tre"

merged_tree = create_merged_tree(tree_X, tree_Y, output_file)
print(merged_tree)

######################## STEP TWO - PRUNING SPECIES TIPS ######################## 
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
species_list = "/user/path/ete3_tree_concatenator/Laurasiatheria_ZFY_ZFX_species_list.txt"
tree_file = "/user/path/ete3_tree_concatenator/Laurasiatheria_concatenated_ZFY_ZFX.tre"
final_output_tree = "/user/path/ete3_tree_concatenator/Laurasiatheria_ZFY_ZFX_for_IQTREE.tre"

    
pruned_tree = prune_tree(tree_file, species_list, final_output_tree)
print(pruned_tree)
