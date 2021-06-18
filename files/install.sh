#!/bin/sh

CUDA=cpu
if [ $# -gt 0 ]; then
	CUDA=$1
fi

CUDA_TARGETS="torch==1.9.0
torchvision==0.10.0"
TARGETS="torchaudio==0.9.0"

JUPYTER_CONFIG=/root/.jupyter/jupyter_notebook_config.py
IPYTHON_CONFIG=/root/.ipython/profile_default/ipython_config.py

case $(arch) in
    aarch64|arm64)
        ;;
    x86_64|amd64)
        # build for cuda 11.1
        lines=$(echo "${CUDA_TARGETS}" | while read line; do
            echo $line+${CUDA}
        done)
        CUDA_TARGETS=$lines
        ;;
    *)
        exit 1
esac


cd $(dirname $0) || exit 1

apt update || exit 1
apt -y upgrade || exit 1

pip3 install ${CUDA_TARGETS} ${TARGETS} -f https://download.pytorch.org/whl/torch_stable.html || exit 1
pip --no-cache-dir install seaborn jupyter jupyterlab scikit-learn imblearn statsmodels || exit 1
jupyter notebook --generate-config --allow-root || exit 1
ipython3 profile create || exit 1

apt -y autoremove
apt clean
rm -rf /var/lib/apt/lists/*

if [ ! -d $(dirname ${JUPYTER_CONFIG}) ]; then
    mkdir -p $(dirname ${JUPYTER_CONFIG})
fi
if [ ! -d $(dirname ${IPYTHON_CONFIG}) ]; then
    mkdir -p $(dirname ${IPYTHON_CONFIG})
fi

cat $(basename ${JUPYTER_CONFIG}) >  $(dirname ${JUPYTER_CONFIG}) || exit 1
cat $(basename ${IPYTHON_CONFIG}) >> $(dirname ${IPYTHON_CONFIG}) || exit 1
