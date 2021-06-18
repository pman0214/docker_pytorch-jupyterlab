#!/bin/sh

cd $(dirname $0) || exit 1

CUDA_TARGETS="torch==1.9.0
torchvision==0.10.0"
TARGETS="torchaudio==0.9.0"

case $(arch) in
    aarch64|arm64)
        ;;
    x86_64|amd64)
        # build for cpu
        lines=$(echo "${CUDA_TARGETS}" | while read line; do
            echo $line+cpu
        done)
        CUDA_TARGETS=$lines
        ;;
    *)
        exit 1
esac

set -x

pip3 install ${CUDA_TARGETS} ${TARGETS} -f https://download.pytorch.org/whl/torch_stable.html || exit 1
