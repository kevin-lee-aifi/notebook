#!/bin/bash

# ============================================================================
# GSE249005 Complete Dataset Download Script
# ============================================================================
# 
# Dataset: Generation of complex human induced pluripotent stem cell-derived bone marrow organoids
# DOI: PMID 38374263
# Institution: Ludwig-Maximilians-University Munich (Department of Pediatrics)
# 
# This script downloads all supplementary files from GSE249005, which contains
# single-cell RNA-seq data from human iPSC-derived bone marrow organoids.
#
# STUDY OVERVIEW:
# - Human bone marrow organoids derived from induced pluripotent stem cells (iPSCs)
# - Single-cell RNA sequencing analysis using Illumina NovaSeq 6000
# - Study of cell composition and hematopoietic development in bone marrow organoids
#
# DATA TYPES:
# - Single-cell RNA-seq data from dissociated bone marrow organoids
#
# DATA PROCESSING LEVELS:
# - Raw data: Unprocessed sequencing files (FASTQ format via SRA)
# - Processed data: Gene expression matrices, cell annotations
# - Analysis results: As provided in the GEO submission
#
# TECHNOLOGIES USED:
# - Illumina NovaSeq 6000
# - Single-cell RNA sequencing
#
# ============================================================================

# ============================================================================
# DIRECTORY SETUP
# ============================================================================

# Define the dataset-specific folder name
DATASET_DIR="GSE249005_bone_marrow_organoids"

# Check if '../data' folder exists (parent directory), create if it doesn't
if [ -d "../data" ]; then
    echo "✓ Found existing 'data' folder in parent directory"
    DATA_BASE="../data"
else
    echo "✓ Creating 'data' folder in parent directory"
    mkdir -p "../data"
    DATA_BASE="../data"
fi

# Create the dataset-specific subfolder within data
FULL_DATA_PATH="$DATA_BASE/$DATASET_DIR"

# Remove existing folder if it exists and create fresh directory
if [ -d "$FULL_DATA_PATH" ]; then
    echo "✓ Removing existing dataset folder: $FULL_DATA_PATH"
    rm -rf "$FULL_DATA_PATH"
fi

echo "✓ Creating fresh dataset folder: $FULL_DATA_PATH"
mkdir -p "$FULL_DATA_PATH"
cd "$FULL_DATA_PATH"

# Get absolute path for user reference
ABSOLUTE_PATH=$(pwd)
echo "✓ Data will be downloaded to: $ABSOLUTE_PATH"
echo ""

echo "Starting download of GSE249005 dataset..."
echo "Total expected download size: ~50-100 MB (estimated)"
echo "Number of files to download: 5-10 files (estimated)"
echo ""

# ============================================================================
# RAW TAR OF SUPPLEMENTARY FILES
# ============================================================================
echo "=== Downloading raw TAR of supplementary files ==="

echo "Downloading: All supplementary files as TAR archive"
curl -L -o "GSE249005_RAW.tar" \
"https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE249005&format=file"

# Decompress the downloaded file
echo "Decompressing TAR file..."
tar -xvf "GSE249005_RAW.tar"

# ============================================================================
# CLEANUP AND RETURN TO ORIGINAL DIRECTORY
# ============================================================================

# Return to the original directory
cd "/home/workspace/notebook/download_scripts"

echo ""
echo "=== Download Complete ==="
echo "Files downloaded to: $ABSOLUTE_PATH"
echo ""