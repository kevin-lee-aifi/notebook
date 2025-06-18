#!/usr/bin/bash

R_ENV="/home/workspace/environment/notebook_r_env"

conda create -y -p $R_ENV -c conda-forge \
    r-base=4.3 \
    r-ggplot2 r-dplyr r-tidyr \
    r-irkernel \
    r-seurat r-seuratobject \

conda activate $R_ENV

# R -e "if (!requireNamespace('remotes', quietly = TRUE)) install.packages('remotes', repos='https://cran.r-project.org'); remotes::install_github('mojaveazure/seurat-disk')"

R -e "IRkernel::installspec(name = 'notebook_r_env', displayname = 'R (notebook)')"