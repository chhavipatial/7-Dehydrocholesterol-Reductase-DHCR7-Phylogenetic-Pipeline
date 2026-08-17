# 7-Dehydrocholesterol-Reductase-DHCR7-Phylogenetic-Pipeline
Identification of DHCR7 homologs and phylogenetic analysis in potato.


## Overview

This repository contains the Bash workflow used for the identification of DHCR7 homologs and phylogenetic analysis in potato.


## Workflow

1. Build BLAST database
2. Search homologs using BLASTn
3. Extract homolog IDs
4. Retrieve homologous sequences using SeqKit
5. Merge DM and Atlantic CDS
6. Multiple sequence alignment using MAFFT
7. Maximum-likelihood tree construction using IQ-TREE2
8. Tree visualization using iTOL

---

## Software

| Software | Purpose |
|-----------|---------|
| BLAST+ | Homolog identification |
| SeqKit | Sequence extraction |
| MAFFT | Multiple sequence alignment |
| IQ-TREE2 | Maximum-likelihood phylogeny |
| iTOL | Tree visualization |

---

