#!/usr/bin/bash

PY_ENV="/home/workspace/environment/notebook_py_env"

# Create conda environment with Python and R packages
conda create -y -p $PY_ENV -c conda-forge python=3.9 \
    ipykernel \
    scanpy anndata h5py \
    numpy pandas glob \
    matplotlib seaborn \
    dill \

# Activate the environment
conda activate $PY_ENV

# Install the Jupyter kernel
python -m ipykernel install --user --name=notebook_py_env --display-name="Python (notebook)"