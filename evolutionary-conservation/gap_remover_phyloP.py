"""
Script title: gap_remover_phyloP.py
Author: Emmarie Alexander
Date written: 10-December-2024
Date last updated: 10-December-2024
Purpose: For calculating phyloP scores, you must choose a reference species or sequence. PhyloP scores will not be calculated at any position where a gap is present. This script takes a reference species and removes any sites in the alignment where there is a gap at that site in the reference species.
"""
from Bio import SeqIO
from Bio import AlignIO
from Bio.Seq import Seq
from Bio.Align import MultipleSeqAlignment

def remove_gaps_by_reference(input_file, reference_name, output_file):
    alignment = AlignIO.read(input_file, "fasta")

    # Find the reference sequence index
    reference_index = None
    for i, record in enumerate(alignment):
        if record.id == reference_name:
            reference_index = i
            break

    if reference_index is None:
        raise ValueError(f"Reference sequence '{reference_name}' not found in the input file.")

    # Create a new alignment with gaps removed
    new_alignment = MultipleSeqAlignment([])
    for record in alignment:
        # Create a new sequence with gaps removed
        new_seq = ''.join(base for i, base in enumerate(record.seq) if alignment[reference_index].seq[i] != '-')
        new_alignment.append(SeqIO.SeqRecord(Seq(new_seq), id=record.id, description=record.description))

    AlignIO.write(new_alignment, output_file, "fasta")

# Example usage:
input_file = "/user/path/input_alignment.fasta"
reference_name = "Bos_taurus"
output_file = "/user/path/alignment_gapsRemoved.fasta"

remove_gaps_by_reference(input_file, reference_name, output_file)
