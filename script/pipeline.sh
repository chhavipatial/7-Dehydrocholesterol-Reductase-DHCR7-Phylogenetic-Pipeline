#!/bin/bash

###############################################################################
# DHCR7 Phylogenetic Analysis Pipeline
#
# This script:
# 1. Creates a BLAST database
# 2. Finds Atlantic homologs
# 3. Extracts homolog sequences
# 4. Combines DM and Atlantic sequences
# 5. Performs sequence alignment
# 6. Builds a phylogenetic tree
#
###############################################################################

# Input files

DM_CDS="DHCR7_DM.fa"
ATL_CDS="ATL_v3.hc_gene_models.cds.fa"

# Output folder

OUTDIR="DHCR7_results"

mkdir -p $OUTDIR

###############################################################################
# STEP 1: Create BLAST database
###############################################################################

echo "Creating BLAST database..."

makeblastdb \
-in $ATL_CDS \
-dbtype nucl \
-out $OUTDIR/Atlantic_DB

###############################################################################
# STEP 2: Search for homologous sequences
###############################################################################

echo "Running BLAST..."

blastn \
-query $DM_CDS \
-db $OUTDIR/Atlantic_DB \
-evalue 1e-10 \
-outfmt 6 \
-out $OUTDIR/blast_results.tsv

###############################################################################
# STEP 3: Extract Atlantic IDs
###############################################################################

echo "Extracting IDs..."

cut -f2 $OUTDIR/blast_results.tsv | sort | uniq \
> $OUTDIR/Atlantic_IDs.txt

###############################################################################
# STEP 4: Extract homolog sequences
###############################################################################

echo "Extracting sequences..."

seqkit grep \
-f $OUTDIR/Atlantic_IDs.txt \
$ATL_CDS \
> $OUTDIR/Atlantic_Homologs.fa

###############################################################################
# STEP 5: Combine sequences
###############################################################################

echo "Combining sequences..."

cat \
$DM_CDS \
$OUTDIR/Atlantic_Homologs.fa \
> $OUTDIR/DHCR7_combined.fa

###############################################################################
# STEP 6: Multiple sequence alignment
###############################################################################

echo "Running MAFFT..."

mafft --auto \
$OUTDIR/DHCR7_combined.fa \
> $OUTDIR/DHCR7_aligned.fa

###############################################################################
# STEP 7: Build phylogenetic tree
###############################################################################

echo "Running IQ-TREE..."

iqtree2 \
-s $OUTDIR/DHCR7_aligned.fa \
-m MFP \
-B 1000 \
-pre $OUTDIR/DHCR7

###############################################################################
# STEP 8: Results
###############################################################################

echo ""
echo "Analysis Complete!"
echo ""

echo "Tree file:"
echo "$OUTDIR/DHCR7.treefile"

echo ""
echo "Upload DHCR7.treefile to iTOL for visualization."
