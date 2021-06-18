#!/bin/sh

cd $(dirname $0) || exit 1

JUPYTER_CONFIG=/root/.jupyter/jupyter_notebook_config.py
IPYTHON_CONFIG=/root/.ipython/profile_default/ipython_config.py

apt update || exit 1
apt -y upgrade || exit 1
apt -y install tzdata build-essential || exit 1
apt -y autoremove
apt clean
rm -rf /var/lib/apt/lists/*

pip --no-cache-dir install seaborn jupyter jupyterlab scikit-learn imblearn statsmodels || exit 1
jupyter notebook --generate-config --allow-root || exit 1
ipython3 profile create || exit 1

if [ ! -d $(dirname ${JUPYTER_CONFIG}) ]; then
    mkdir -p $(dirname ${JUPYTER_CONFIG})
fi
if [ ! -d $(dirname ${IPYTHON_CONFIG}) ]; then
    mkdir -p $(dirname ${IPYTHON_CONFIG})
fi

cat $(basename ${JUPYTER_CONFIG}) >  ${JUPYTER_CONFIG} || exit 1
cat $(basename ${IPYTHON_CONFIG}) >> ${IPYTHON_CONFIG} || exit 1
