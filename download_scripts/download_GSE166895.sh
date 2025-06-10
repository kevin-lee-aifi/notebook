#!/bin/bash

# ============================================================================
# GSE166895 Complete Dataset Download Script
# ============================================================================
# 
# Dataset: Blood and immune cell development in human fetal bone marrow and in Down syndrome
# DOI: PMID 34588693
# Institution: University of Cambridge (Bertie Gottgens lab)
# 
# This script downloads all supplementary files from GSE166895, which contains
# single-cell RNA-seq with CITE-seq data from human fetal development.
#
# STUDY OVERVIEW:
# - Examines blood and immune cell development in human fetal bone marrow
# - Compares fetal bone marrow (FBM) vs fetal liver (FL) hematopoiesis  
# - Includes Down syndrome samples showing developmental disruption
# - Uses single-cell RNA-seq + CITE-seq (simultaneous protein detection)
#
# SAMPLE TYPES:
# - FBM: Fetal Bone Marrow
# - FL: Fetal Liver  
# - CB: Cord Blood
# - MNCs: Mononuclear Cells
# - CD34+: Hematopoietic stem/progenitor cells
# - CD34+ Sinu: CD34+ Sinusoidal Endothelial Cells
#
# DATA PROCESSING LEVELS:
# - preQC: Raw data post-Cell Ranger or CITE-seq-Count (before quality control)
# - postQC: After quality control, doublet removal, demultiplexing
# - overlap: Cells that have both mRNA and protein data
# - DSB normalised: Denoised and Scaled by Background (protein normalization)
#
# ============================================================================

# ============================================================================
# DIRECTORY SETUP
# ============================================================================

# Define the dataset-specific folder name
DATASET_DIR="GSE166895_fetal_hematopoiesis"

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
echo "✓ Creating dataset folder: $FULL_DATA_PATH"
mkdir -p "$FULL_DATA_PATH"
cd "$FULL_DATA_PATH"

# Get absolute path for user reference
ABSOLUTE_PATH=$(pwd)
echo "✓ Data will be downloaded to: $ABSOLUTE_PATH"
echo ""

echo "Starting download of GSE166895 dataset..."
echo "Total expected download size: ~651 MB"
echo "Number of files to download: 14"
echo ""

# ============================================================================
# SINUSOIDAL ENDOTHELIAL CELL DATA (CD34+ Sinu)
# ============================================================================
echo "=== Downloading Sinusoidal Endothelial Cell Data ==="

# Raw mRNA from CD34+ Sinusoidal Endothelial Cells (Fetal Liver and Fetal Bone Marrow)
echo "Downloading: Raw mRNA CD34+ Sinusoidal EC (FL + FBM) [3.2 MB]"
curl -L -o "GSE166895_Raw_mRNA_CD34Sinu_FLFBM.csv.gz" \
"https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE166895&format=file&file=GSE166895%5FRaw%5FmRNA%5FCD34Sinu%5FFLFBM%2Ecsv%2Egz"

# Raw protein data from CD34+ Sinusoidal Endothelial Cells  
echo "Downloading: Raw protein CD34+ Sinusoidal EC (FL + FBM) [216.4 KB]"
curl -L -o "GSE166895_Raw_ADT_CD34Sinu_FLFBM.csv.gz" \
"https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE166895&format=file&file=GSE166895%5FRaw%5FADT%5FCD34Sinu%5FFLFBM%2Ecsv%2Egz"

# DSB normalized protein data from CD34+ Sinusoidal EC (post mRNA overlap)
echo "Downloading: DSB normalized protein CD34+ Sinusoidal EC [672.2 KB]"
curl -L -o "GSE166895_ADT_DSBnormalised_postmRNAoverlap_CD34Sinu.csv.gz" \
"https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE166895&format=file&file=GSE166895%5FADT%5FDSBnormalised%5FpostmRNAoverlap%5FCD34Sinu%2Ecsv%2Egz"

echo ""

# ============================================================================
# FETAL BONE MARROW MONONUCLEAR CELLS (FBM-MNCs)
# ============================================================================
echo "=== Downloading Fetal Bone Marrow MNC Data ==="

# Pre-QC data (raw from Cell Ranger and CITE-seq-Count)
echo "Downloading: Pre-QC mRNA FBM MNCs [49.4 MB]"
curl -L -o "GSE166895_preQC_mRNAraw_FBM-MNCs.csv.gz" \
"https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE166895&format=file&file=GSE166895%5FpreQC%5FmRNAraw%5FFBM%2DMNCs%2Ecsv%2Egz"

echo "Downloading: Pre-QC protein FBM MNCs [2.9 MB]"
curl -L -o "GSE166895_preQC_ADTraw_FBM-MNCs.csv.gz" \
"https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE166895&format=file&file=GSE166895%5FpreQC%5FADTraw%5FFBM%2DMNCs%2Ecsv%2Egz"

# Post-QC data (after quality control and doublet removal)
echo "Downloading: Post-QC mRNA FBM MNCs [41.7 MB]"
curl -L -o "GSE166895_postQC_mRNAraw_FBM-MNCs.csv.gz" \
"https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE166895&format=file&file=GSE166895%5FpostQC%5FmRNAraw%5FFBM%2DMNCs%2Ecsv%2Egz"

echo "Downloading: Post-QC protein FBM MNCs [1.3 MB]"
curl -L -o "GSE166895_postQC_ADT_raw_FBM-MNCs.csv.gz" \
"https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE166895&format=file&file=GSE166895%5FpostQC%5FADT%5Fraw%5FFBM%2DMNCs%2Ecsv%2Egz"

# Overlap data (cells with both mRNA and protein data)
echo "Downloading: Raw protein FBM MNCs (post mRNA overlap) [1.0 MB]"
curl -L -o "GSE166895_overlap_ADTonmRNA_raw_FBM-MNCs.csv.gz" \
"https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE166895&format=file&file=GSE166895%5Foverlap%5FADTonmRNA%5Fraw%5FFBM%2DMNCs%2Ecsv%2Egz"

echo "Downloading: DSB normalized protein FBM MNCs [3.3 MB]"
curl -L -o "GSE166895_overlap_ADTonmRNA_DSBnormalised_FBM-MNCs.csv.gz" \
"https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE166895&format=file&file=GSE166895%5Foverlap%5FADTonmRNA%5FDSBnormalised%5FFBM%2DMNCs%2Ecsv%2Egz"

echo ""

# ============================================================================
# COMBINED DATASETS (FL-FBM-CB: Fetal Liver + Fetal Bone Marrow + Cord Blood)
# ============================================================================
echo "=== Downloading Combined FL-FBM-CB Data ==="

# Pre-QC combined data
echo "Downloading: Pre-QC mRNA FL-FBM-CB combined [393.0 MB] - LARGEST FILE"
curl -L -o "GSE166895_preQC_mRNAraw_FL-FBM-CB.csv.gz" \
"https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE166895&format=file&file=GSE166895%5FpreQC%5FmRNAraw%5FFL%2DFBM%2DCB%2Ecsv%2Egz"

echo "Downloading: Pre-QC protein FL-FBM-CB combined [16.3 MB]"
curl -L -o "GSE166895_preQC_ADTraw_FL-FBM-CB.csv.gz" \
"https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE166895&format=file&file=GSE166895%5FpreQC%5FADTraw%5FFL%2DFBM%2DCB%2Ecsv%2Egz"

# Post-QC combined data
echo "Downloading: Post-QC mRNA FL-FBM-CB combined [154.6 MB]"
curl -L -o "GSE166895_postQC_mRNAraw_FL-FBM-CB.csv.gz" \
"https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE166895&format=file&file=GSE166895%5FpostQC%5FmRNAraw%5FFL%2DFBM%2DCB%2Ecsv%2Egz"

# Overlap combined data (cells with both mRNA and protein)
echo "Downloading: Raw protein FL-FBM-CB (post QC + overlap) [3.2 MB]"
curl -L -o "GSE166895_overlap_ADTonmRNAraw_FL-FBM-CB.csv.gz" \
"https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE166895&format=file&file=GSE166895%5Foverlap%5FADTonmRNAraw%5FFL%2DFBM%2DCB%2Ecsv%2Egz"

echo "Downloading: DSB normalized protein FL-FBM-CB (CD34+ progenitors) [10.2 MB]"
curl -L -o "GSE166895_overlap_ADTonmRNADSBnormalised_FL-FBM-CB.csv.gz" \
"https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE166895&format=file&file=GSE166895%5Foverlap%5FADTonmRNADSBnormalised%5FFL%2DFBM%2DCB%2Ecsv%2Egz"

echo ""
echo "=== Download Complete ==="
echo ""