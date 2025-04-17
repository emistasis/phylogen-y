## Author: Emmarie Alexander
## Purpose: Extract certain regions from a chromosome, such as extracting certain genes based on their start and end position, and store it into a new FASTA file.

from Bio import SeqIO

def extract_genomic_region(fasta_file, start_pos, end_pos):
    # Read the FASTA file
    sequence = SeqIO.read(fasta_file, "fasta").seq

    # Extract the sequence for the specified genomic positions
    return sequence[start_pos - 1:end_pos]

if __name__ == "__main__":
    # Specify the input FASTA file, gene information, and output file
    input_fasta = "/user/path/input_chromosome_masked.fna"
    output_fasta = "/user/path/output_3genes_fromChromosome_masked.fna"

    gene_info = [
        {"gene_name": "gene1", "start_position": 14140601, "end_position": 14387359, "output_file": "gene1.fasta"},
        {"gene_name": "gene2", "start_position": 13609504, "end_position": 13769113, "output_file": "gene2.fasta"},
        {"gene_name": "gene3", "start_position": 13812270, "end_position": 13828749, "output_file": "gene3.fasta"}
    ]

    # Extract the gene sequences and append to a single output FASTA file
    with open(output_fasta, "w") as output_handle:
        for gene_data in gene_info:
            gene_sequence = extract_genomic_region(input_fasta, gene_data["start_position"], gene_data["end_position"])
            output_handle.write(f">{gene_data['gene_name']}\n{gene_sequence}\n")
