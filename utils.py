import pandas as pd
import numpy as np
import anndata as ad
import scanpy as sc
import h5py as h5
import glob
from scipy.stats import median_abs_deviation
import os

def is_outlier(adata, metric: str, nmads: int):
    M = adata.obs[metric]
    outlier = (M < np.median(M) - nmads * median_abs_deviation(M)) | (
        np.median(M) + nmads * median_abs_deviation(M) < M
    )
    return outlier