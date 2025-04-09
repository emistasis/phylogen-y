"""
Script title: iqtree_topologyTest_extractor.v2.py
Author: Emmarie Alexander
Date written: 2-April-2025
Last updated: 2-April-2025

Summary v2: Sorting by numerical order (human-sorting), argparse.
Summary v1: There appears to be differences in the number of treefiles in the unconstrained and constrained directories. I need to modify the script to count number of files and make sure they're the same.

Purpose: This script works to extract the topology test outputs from multiple .iqtree files
"""

import os
import re
import argparse
from pathlib import Path

def main(args):
    """
    Extracts the tree topology results that appear underneath "USER TREES" in the .iqtree report.

    iqtree_dir: Path to the folder containing iqtree files.
    file_suffix: File extension specifying .iqtree
    output_file: Path to the generated output file.
    """
    iqtree_dir = args.iqtree_dir
    output_file = args.output_file
    file_suffix = args.file_suffix

    # Get filenames and sort them numerically
    filenames = sorted(
        (f for f in os.listdir(iqtree_dir) if f.endswith(file_suffix)),
        key=lambda x: int(re.search(r"(\d+)", x).group(1)) if re.search(r"(\d+)", x) else float('inf')
    )

    if not filenames:
        print("No .iqtree files were found in the directory.")
        return

    with open(output_file, "a", encoding="utf-8") as out_file:
        for filename in filenames:
            file_path = os.path.join(iqtree_dir, filename)

            if os.path.isfile(file_path):
                print(f"Processing {filename}")
                with open(file_path, "r", encoding="utf-8") as f:
                    lines = f.readlines()

                    found = False  # Checks to see if "USER TREES" is found
                    for i, line in enumerate(lines):
                        if "USER TREES" in line.upper():
                            found = True
                            out_file.write(f"Extracted from: {filename}\n")
                            out_file.writelines(lines[i:i+9])
                            out_file.write("\n--\n")
                            break

                    if not found:
                        print(f"No topology test results were found in {filename}.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Process .iqtree files and generate an output file containing all topology test results.")
    parser.add_argument("--iqtree_dir", required=True, help="Path to the directory containing the .iqtree files.")
    parser.add_argument("--output_file", required=True, help="Path to the file that will contain the results.")
    parser.add_argument("--file_suffix", required=True, help="Specify the file extension. This should always be set to .iqtree")

    args = parser.parse_args()
    main(args)
