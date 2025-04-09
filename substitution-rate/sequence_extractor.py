"""
Script title: sequence_extractor.v1.py
Author: Emmarie Alexander
Date written: 8-April-2025
Last updated: 9-April-2025
Version: 1.0
Purpose: This script extracts specified regions from a FASTA alignment based on a regions file.
"""

## ===================================README=========================================
# This script acts similarly to bedtool's getfasta function.
# The user provides several files: a FASTA alignment file, a regions file, and optionally a taxa file.
# The FASTA alignment should be a multiple-sequence alignment in FASTA format.
# The regions file should specify the regions to extract, including the region name, start position, and end position. It should be tab-delimited and resemble a BED file.
# The (optional) taxa file should include all the names of taxa to be extracted from the main FASTA file. If not provided, all taxa in the FASTA file will be included.
# For the taxa file, do not include ">" before the taxa_names. All names need to be identical to what occurs in the FASTA file.
# The script will then run through and extract the provided regions, outputting them into a new FASTA file.
# Sequence headers in the new FASTA will be formatted as follows: >taxa_name|region_name.

"""
Example format for the regions text file:
    region_name    start_position    end_position
    gene1        1234              5678
    gene2        100               500
"""

from argparse import ArgumentParser
from pyfaidx import Fasta


def parse_regions_file(regions_file):
    """
    Parse the regions file to extract region name, start position, and end position.
    The file should have three tab-separated values: region_name, start_position, end_position.
    """
    regions = []
    with open(regions_file, "r") as file:
        for line in file:
            line = line.strip()
            if not line or line.startswith("#"):  # Skip empty lines or comments
                continue
            parts = line.split("\t")
            if len(parts) < 3:
                raise ValueError(f"Invalid region format: {line}")
            region_name = parts[0]
            start_pos = int(parts[1])
            end_pos = int(parts[2])
            regions.append({"region_name": region_name, "start_position": start_pos, "end_position": end_pos})
    return regions


def filter_alignment_by_taxa(alignment, taxa_file):
    """
    Filter the alignment to include only the specified taxa.
    """
    with open(taxa_file, "r") as taxa_handle:
        taxa_names = [line.strip() for line in taxa_handle if line.strip()]

    filtered_records = {}
    for taxa in taxa_names:
        if taxa in alignment.keys():
            filtered_records[taxa] = alignment[taxa]
        else:
            print(f"Warning: {taxa} not found in the alignment.")

    if not filtered_records:
        raise ValueError("None of the specified taxa were found in the alignment.")

    return filtered_records


def main(args):
    # Parse the regions file
    regions = parse_regions_file(args.regions)

    # Read the input FASTA alignment file using pyfaidx
    alignment = Fasta(args.input_fasta)

    # Filter alignment by taxa if a taxa file is provided
    if args.taxa_file:
        filtered_records = filter_alignment_by_taxa(alignment, args.taxa_file)
    else:
        # If no taxa file is provided, use all sequences
        filtered_records = {record.name: record for record in alignment}

    # Ensure that the output file name ends with '.fa' or '.fasta'
    if not (args.output_fasta.endswith(".fa") or args.output_fasta.endswith(".fasta")):
        output_fasta = args.output_fasta + ".fa"
    else:
        output_fasta = args.output_fasta

    # Write the extracted regions to the output file
    with open(output_fasta, "w") as output_handle:
        for region in regions:
            region_name = region["region_name"]
            start_pos = region["start_position"]
            end_pos = region["end_position"]

            # Loop through the filtered records and extract the region for each taxa
            for taxa, record in filtered_records.items():
                # Extract the subsequence
                subseq = record[start_pos - 1:end_pos].seq
                # Write the extracted region to the output file
                output_handle.write(f">{taxa}|{region_name}\n{subseq}\n")

    print(f"Extracted regions from alignment and saved to {output_fasta}")


if __name__ == "__main__":
    parser = ArgumentParser(description="Extract specified regions from a FASTA alignment and save to a new FASTA file.")
    parser.add_argument("--input_fasta", required=True, help="Path to the input FASTA alignment file.")
    parser.add_argument("--output_fasta", required=True, help="Path to the output FASTA file.")
    parser.add_argument("--regions", required=True, help="Path to a text or BED file containing the regions to extract (start and end positions).")
    parser.add_argument("--taxa_file", help="Optional file containing a list of taxa names to include in the output.")

    args = parser.parse_args()
    main(args)
