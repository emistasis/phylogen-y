## Author: Emmarie P. Alexander
## Date: March 2023
## Purpose: This Python script can be used to download coding sequences from NCBI for certain genes specified by the user via an input .txt file

import Bio
from Bio import Entrez
from Bio import SeqIO

# set email for NCBI Entrez usage
Entrez.email = 'user@tamu.edu

# provide a text file that lists the accessions of what genes you would like the coding sequence for
with open('accessions.txt','r') as f:
    accessions = [line.strip() for line in f.readlines()]


for accession in accessions:
    handle = Entrez.efetch(db='nuccore', id=accession, rettype='fasta_cds_na', retmode='text')
    record = SeqIO.read(handle, 'fasta')
    organism = record.description.split("[")[1].split("]")[0]
    record.description = f'{record.description}[{organism}]'

# adjust the names of output files
codingSeqs = f'{accession}.fasta'
SeqIO.write(record, codingSeqs, 'fasta')
