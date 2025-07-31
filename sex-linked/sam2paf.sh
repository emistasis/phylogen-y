# SAM alignment files can be converted into PAF two ways: using bioconvert or minimap2.

# Here is the command to convert using bioconvert.v.1.1.1
for f in *.sam; do
    bioconvert sam2paf "$f" "${f%.sam}.paf"
done

# Here is the command to convert using minimap2
paftools.js sam2paf in.sam > out.paf
