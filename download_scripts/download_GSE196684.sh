#!/bin/bash

# ============================================================================
# GSE196684 Complete Dataset Download Script
# ============================================================================
# 
# Dataset: A human bone marrow organoid for disease modelling and drug screening in blood cancers
# DOI: PMID 36351055
# Institution: University of Birmingham (Institute of Cardiovascular Science)
# 
# This script downloads all supplementary files from GSE196684, which contains
# single-cell RNA-seq data from human bone marrow organoids.
#
# STUDY OVERVIEW:
# - Human bone marrow organoids derived from induced pluripotent stem cells (iPSCs)
# - Disease modeling for blood cancers and drug screening applications
# - Single-cell RNA sequencing analysis using 10x Genomics platform
# - Comparison of 2 different cytokine formulations for organoid generation
#
# ORGANOID TYPES:
# - VEGFA: Organoids stimulated with VEGFA only
# - VEGFA+C: Organoids stimulated with VEGFA + VEGFC combination
# - Both types contain hematopoietic stem/progenitor cells, endothelial cells, and mesenchymal cells
#
# DATA PROCESSING LEVELS:
# - Raw data: Unprocessed sequencing files (FASTQ format via SRA)
# - Processed data: Gene expression matrices, cell annotations
# - Analysis results: Differential expression, cell type identification
#
# TECHNOLOGIES USED:
# - 10x Genomics single-cell RNA sequencing
# - Cell Ranger pipeline for initial processing
# - Seurat/R analysis for downstream processing
#
# ============================================================================

# ============================================================================
# DIRECTORY SETUP
# ============================================================================

# Define the dataset-specific folder name
DATASET_DIR="GSE196684_bone_marrow_organoids"

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

echo "Starting download of GSE196684 dataset..."
echo "Total expected download size: ~50-100 MB (estimated)"
echo "Number of files to download: 6-8 files"
echo ""

# ============================================================================
# RAW TAR OF RDS FILES
# ============================================================================
echo "=== Downloading raw TAR of RDS files ==="

echo "Downloading: All supplementary files as TAR archive"
curl -L -o "GSE196684_RAW.tar" \
"https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE196684&format=file"

# Decompress the downloaded file
echo "Decompressing TAR file..."
tar -xvf  "GSE196684_RAW.tar"

# Decompress the downloaded file
echo "Decompressing RDS file..."
gunzip "GSM5898130_VEGFAC_analysis.rds.gz"
gunzip "GSM5898131_VEGFA_analysis.rds.gz"

# ============================================================================
# INTEGRATED VEGFA AND VEGFAC R OBJECTS
# ============================================================================
echo "=== Downloading Integrated R Objects ==="

echo "Downloading: Integrated VEGFA and VEGFA+C R Object [~20-50 MB]"
curl -L -o "GSE196684_Integrated_VEGFA_C_R_Object.rds.gz" \
"https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE196684&format=file&file=GSE196684%5FIntegrated%5FVEGFA%5FC%5FR%5FObject%2Erds%2Egz"

# Decompress the downloaded file
echo "Decompressing RDS file..."
gunzip "GSE196684_Integrated_VEGFA_C_R_Object.rds.gz"

cd "/home/workspace/notebook/download_scripts"

echo ""
echo "=== Download Complete ==="
echo ""