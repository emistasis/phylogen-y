## Author: Emmarie Alexander
## Date: July 2023
## Purpose: This script was written to remove user-specified regions from a FASTA file. In particular, I wrote this script to remove all of the pseudogenes for USP9Y from the Homo sapiens T2T Y-chromosome.

from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord

def remove_regions(sequence, regions_to_remove):
    for start, end in regions_to_remove:
        sequence = sequence[:start-1] + sequence[end:]
    return sequence

def read_regions_from_file(file_path):
    regions_to_remove = []
    with open(file_path, "r") as file:
        for line in file:
            start, end = map(int, line.strip().split('\t'))
            regions_to_remove.append((start, end))
    return regions_to_remove

def main():
    input_file = "/path/to/input_file.fasta" # change this to the path of your input FASTA file that you want regions stripped from
    output_file = "/path/to/output_file.fasta" # change this an informative FASTA file titled appropriately, e.g. "HomSap_T2T_Ychr_USP9Y_pseudogenes_removed.fasta"
    regions_file = "/path/to/regions_to_be_removed.fasta" # change this to the path of a text file that contains start and end coordinates for the regions you want to remove

    # Read regions from the file
    regions_to_remove = read_regions_from_file(regions_file)

    records = []
    with open(input_file, "r") as handle:
        for record in SeqIO.parse(handle, "fasta"):
            sequence = remove_regions(str(record.seq), regions_to_remove)
            new_record = SeqRecord(Seq(sequence), id=record.id, description=record.description)
            records.append(new_record)

    with open(output_file, "w") as output_handle:
        SeqIO.write(records, output_handle, "fasta")

if __name__ == "__main__":
    main()
