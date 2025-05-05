"""
Script title: find_extract_clean_treeFile.py
Author: Emmarie Alexander
Date written: 21-Feb-2025
Date last updated: 21-Feb-2025
Purpose: When running a sliding window analysis, IQ-TREE is run for each window and outputs a series of files. One of these files is the .treefile, which contains the best tree. However, since we used the GHOST model, there is a tree outputted for each parameter.
The purpose of this CLI script is to extract the best tree (the first line) for each window from its .treefile.
"""

import os # os handles directories
import shutil # shutil allows for shell-like utilities
import argparse # argparse allows the script user to specify an argument
import re # re handles regular expressions


def copy_and_extract(root_dir, destination_dir, output_file):
    # Make sure that the destination directory exists
    os.makedirs(destination_dir, exist_ok=True)

    # Sort the folder names by numerical value, assuming that the folder names are an interger and correspond to their window number
    folders = sorted(os.listdir(root_dir), key=lambda x: int(x))
    
    # Open the output file to write
    with open(output_file, "w", encoding="utf-8") as out_f:
        for folder in folders:
            folder_path = os.path.join(root_dir, folder)
            
            # Ensure that there is a starting directory
            if os.path.isdir(folder_path):
                # Search for the .treefiles within the directory
                for file in os.listdir(folder_path):
                    if file.endswith(".treefile"):
                        file_path = os.path.join(folder_path, file)
                        dest_path = os.path.join(destination_dir, file)
                        
                        
                        # Ensure that no filename conflicts occur
                        counter = 1
                        while os.path.exists(dest_path):
                            file_name, file_exist = os.path.splitext(file)
                            dest_path = os.path.join(destination_dir, f"{file_name}_{counter}")
                            counter += 1
                        
                        # Copy the file
                        shutil.copy(file_path, dest_path)
                        
                        # Read in the first line and write it to output
                        with open(file_path, "r", encoding="utf-8") as in_f:
                            first_line = in_f.readline().strip()
                            out_f.write(first_line + "\n")
                            
    print(f"Process complete! All .treefile should have been copied to your {destination_dir} and extracted lines as stored in {output_file}!")

def output_cleaner(output_file, cleaned_file):
    # Recognize the regex pattern that matches the unwanted bracket structures (e.g., removes [0.000002/0.000002/0.000002/0.000002] from Callithrix_jacchus_DDX3X[0.000002/0.000002/0.000002/0.000002]:0.000002)
    pattern = r"\[\d+\.\d+/\d+\.\d+/\d+\.\d+/\d+\.\d+\]"
    
    # Read the output file then clean each line
    with open(output_file, "r", encoding="utf-8") as infile, open(cleaned_file, "w", encoding="utf-8") as outfile:
        for line in infile:
            cleaned_line = re.sub(pattern, "", line) # Removes the unwanted bracket structures
            outfile.write(cleaned_line) # Writes the claened line to a new file
            
    print(f"Your file is squeaky clean! Processed line have been saved to {cleaned_file}!")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog="TreeExtractor",        
        description="This script will copy your .treefiles and extract the first lines from each into a single file.")
    parser.add_argument("root_dir", help="provide the path to your original directory that stores all of your tree files.")
    parser.add_argument("destination_dir", help="provide the path to the directory that you want to copy your tree files into.")
    parser.add_argument("output_file", help="provide the path to the output file where yowu want the first lines to be stored in.")
    parser.add_argument("cleaned_file", help="provide the path to your cleaned output file.")
    
    args = parser.parse_args()
    
    copy_and_extract(args.root_dir, args.destination_dir, args.output_file)
    
    output_cleaner(args.output_file, args.cleaned_file)
