"""
Script title: arborist_find_extract_clean.v2.py
Author: Emmarie Alexander
Contact: emmarie.alexander@tamu.edu
Date written: 21-Feb-2025
Date last updated: 09-June-2025
Purpose: When running a sliding window analysis, IQ-TREE is run for each window and outputs a series of files. One of these files is the .treefile, which contains the best tree. However, since we used the GHOST model, there is a tree outputted for each parameter.
The purpose of this CLI script is to extract the best tree (the first line) for each window from its .treefile.
"""

import os
import shutil
import argparse
import re

def extract_int_from_filename(filename):
    # Adjust this regex if your numbering scheme changes
    match = re.search(r'_(\d+)\.tre$', filename)
    return int(match.group(1)) if match else float('inf')

def copy_and_extract(input_dir, output_dir, output_file, file_extension):
    os.makedirs(output_dir, exist_ok=True)

    # Gather all .tre files in the input directory
    tre_files = [
        f for f in os.listdir(input_dir)
        if f.endswith(file_extension) and os.path.isfile(os.path.join(input_dir, f))
    ]

    # Sort files by the integer in their name
    tre_files.sort(key=extract_int_from_filename)

    with open(output_file, "w", encoding="utf-8") as out_f:
        for file in tre_files:
            src_path = os.path.join(input_dir, file)
            dest_path = os.path.join(output_dir, file)
            counter = 1
            while os.path.exists(dest_path):
                file_name, file_ext = os.path.splitext(file)
                dest_path = os.path.join(output_dir, f"{file_name}_{counter}{file_ext}")
                counter += 1

            shutil.copy(src_path, dest_path)
            with open(src_path, "r", encoding="utf-8") as in_f:
                first_line = in_f.readline().strip()
                out_f.write(first_line + "\n")

    print(f"Process complete! All .treefiles copied to {output_dir} and first lines extracted to {output_file}.")

def output_cleaner(output_file, cleaned_file):
    pattern = r"\[\d+\.\d+/\d+\.\d+/\d+\.\d+/\d+\.\d+\]"
    with open(output_file, "r", encoding="utf-8") as infile, open(cleaned_file, "w", encoding="utf-8") as outfile:
        for line in infile:
            cleaned_line = re.sub(pattern, "", line)
            outfile.write(cleaned_line)
    print(f"Your file is squeaky clean! Processed lines saved to {cleaned_file}.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Copy .treefiles from a directory, extract first lines, and clean output."
    )
    parser.add_argument("--input_dir", required=True, help="Directory containing your .treefiles.")
    parser.add_argument("--file_extension", default=".tre", help="File extension for tree files (default: .tre).")
    parser.add_argument("--output_dir", required=True, help="Directory to copy tree files into.")
    parser.add_argument("--output_file", required=True, help="File to store the extracted first lines.")
    parser.add_argument("--cleaned_file", required=True, help="File to store the cleaned output.")

    args = parser.parse_args()
    copy_and_extract(args.input_dir, args.output_dir, args.output_file, args.file_extension)
    output_cleaner(args.output_file, args.cleaned_file)
