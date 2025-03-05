"""
Author: Emmarie Alexander
Date: 30-October-2024
Script name: branch_length_calculator.py
Purpose: the purpose of this script is to calculate the entire branch length for each species in a phylogeny
"""
from ete3 import Tree

def calculate_total_branch_lengths(tree):
    # Initialize a dictionary to hold total branch lengths
    branch_lengths = {}

    # Get all leaves from the tree
    leaves = tree.get_leaves()
    
    # Iterate over each leaf
    for leaf in leaves:
        total_length = 0
        # Walk up to the root from the leaf
        current_node = leaf
        while current_node and current_node.up:  # 'up' is the parent node
            # Add the length of the branch leading to the parent node
            total_length += current_node.dist
            current_node = current_node.up  # Move to the parent node

        # Store the total branch length for this leaf
        branch_lengths[leaf.name] = total_length

    return branch_lengths

# Example usage
if __name__ == "__main__":
    # Change this path to the location of your Newick file
    with open("/user/path/branch_length_calculator/HRA_rooted.tre", "r") as file:
        newick_tree = file.read().strip()  # Read and strip whitespace/newlines
    
    # Create a tree from the Newick string
    tree = Tree(newick_tree, format=1)
    
    # Calculate the total branch lengths
    branch_lengths = calculate_total_branch_lengths(tree)
    
    # Print the branch lengths
    for leaf, length in branch_lengths.items():
        print(f"Total branch length for {leaf}: {length}")
