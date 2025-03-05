# Description: the bioconvert command can be used to convert a SAM file into a PAF file, which is necessary to visualize the dotplots using the R scripts provided. the seqkit command goes through all of the accessions in a text file, finds the matching sequence in a FASTA file, extracts the sequence, and stores it in a new FASTA.

###### BIOCONVERT (v1.1.1) COMMAND
for f in *.sam; do
    bioconvert sam2paf "$f" "${f%.sam}.paf"
done


###### SEQKIT(v0.16.0) COMMAND
# winnowmap scaffold
TargetGenome_wm='/user/path/TargetGenome_chrY_hits.txt'

# target genome
TargetGenome_genome='/user/path/TargetGenome_unplacedScaf.fna'

seqkit grep -f $TargetGenome_wm $TargetGenome_genome > TargetGenome_chrY_hits.fna
