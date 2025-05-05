"""
Script title: treeFile_merger.py
Author: Emmarie Alexander
Date written: 1-April-2025
Last updated: 1-April-2025

Summary v3: Added prefix pairing as I noticed that previously, it was grouping incorrect files.
Summary v2: Counts the number of tree files from both directories. Matches them. Changed the output directory name. Changed the output file names. Added file suffix. Unconstrained trees have ".fasta.treefile" as their extension while constrained trees have ".constr.treefile" as their extension.
Summary v1: There appears to be differences in the number of treefiles in the unconstrained and constrained directories. I need to modify the script to count number of files and make sure they're the same.

Purpose: This script was written to merge the output of multiple IQTREE treefiles to create a treefile that contains multiple trees from separate IQTREE runs. This script is helpful when you're trying to perform a constraint tree search.
"""

## ===================================README=========================================
# This script requires (at least) two input files that are both treefiles where the trees are stored in Newick / Phylip format.
# This script assumes that your trees are in GHOST format, such that each base had a rate parmater calculated and is stored in branches: [1/2/3/4]
# I wrote this script for a gene conversion pipeline, where file one is the unconstrained tree search and file two is the constrained tree search.
# I ran these tree searches in IQ-TREE2 using the GHOST model. I decided not to strip these parameters from the tree since they are informative in their own right for each parameter.

import os
import logging

def setup_logging():
    logging.basicConfig(
        filename='Treefile_Merger_Euarchontoglires_DDX3YX.log', # change to reflect what you're running this script on
        level=logging.DEBUG,
        format='%(asctime)s - %(levelname)s - %(message)s',
        filemode='a')
    logging.info('Program started')

import os
import logging
import re

def extract_first_lines(directory, file_suffix, pairing_dict):
    """
    Extracts the first lines from the treefiles 
    
    directory: Path to the folder containing treefiles.
    file_suffix: Expected suffix for this file type (e.g., '.fasta.treefile' or '.constr.treefile').
    pairing_dict: Dictionary to store first lines indexed by numerical prefix.
    """
    try:
        filenames = sorted(f for f in os.listdir(directory) if f.endswith(file_suffix))

        for filename in filenames:
            match = re.match(r"(\d+)\..*", filename)  # Extract numeric prefix
            if not match:
                logging.warning(f"Skipping {filename}: Cannot determine prefix.")
                continue
            
            file_prefix = int(match.group(2))  # Convert extracted number to integer
            filepath = os.path.join(directory, filename)

            try:
                with open(filepath, 'r') as file:
                    first_line = file.readline().strip()

                    if not first_line:
                        logging.warning(f"{filename} in {directory} is empty.")
                        continue
                    
                    pairing_dict[file_prefix] = first_line  # Store first line with numeric key
            except Exception as e:
                logging.error(f"Error reading {filename}: {e}")

    except Exception as e:
        logging.error(f"Error processing files in {directory}: {e}")

def merge_lines(unconstrained_dict, constrained_dict, output_directory):
    """
    Merges first lines based on numerical prefixes and saves these to an output file.
    The unconstrained tree is the first line (top tree), constrained is the second line (bottom tree).
    
    unconstrained_dict: First lines from unconstrained files (keyed by prefix).
    constrained_dict: First lines from constrained files (keyed by prefix).
    output_directory: Directory to save merged files.
    """
    os.makedirs(output_directory, exist_ok=True)
    
    for key in sorted(unconstrained_dict.keys() & constrained_dict.keys()):  # Ensure matching keys
        output_filepath = os.path.join(output_directory, f"Euarchontoglires_treesearch_{key}.tre")

        logging.info(f"Merging files with prefix {key}: {unconstrained_dict[key]} + {constrained_dict[key]}")

        try:
            with open(output_filepath, "w") as output_file:
                output_file.write(unconstrained_dict[key] + "\n")
                output_file.write(constrained_dict[key] + "\n")
        except Exception as e:
            logging.error(f"Error writing {output_filepath}: {e}")

def main():
    setup_logging()
    
    unconstrained_dir = "./Euarchontoglires_DDX3YX_unconstrained/" # change path
    constrained_dir = "./Euarchontoglires_DDX3YX_constrained/" # change path
    merged_output_dir = "./Euarchontoglires_DDX3YX_treesearches" # change path
    
    unconstrained_dict = {}
    constrained_dict = {}

    extract_first_lines(unconstrained_dir, ".fasta.treefile", unconstrained_dict)
    extract_first_lines(constrained_dir, ".constr.treefile", constrained_dict)
    
    if set(unconstrained_dict.keys()) != set(constrained_dict.keys()):
        logging.warning("Mismatch in file prefixes between unconstrained and constrained files.")

    merge_lines(unconstrained_dict, constrained_dict, merged_output_dir)
    
    logging.info('Script has finished successfully!')

if __name__ == "__main__":
    main()
