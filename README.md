# pytorch + Jupyterlab

## Overview

* Pytorch + Jupyter Docker image based on [python docker image](https://hub.docker.com/_/python).

This image is built with these installation processes.
* Follows pytorch installation procedure on [pytorch official page](https://pytorch.org).
* Installs python modules:
  * seaborn
  * jupyter
  * jupyterlab
  * scikit-learn
  * imblearn
  * statsmodels

Jupyterlab's password is `jupyter`.

## Usage

Run with port opened on 8888. Default workdir is `/app`.
```
docker run --rm -d -v $PWD:/app -p 8888:8888 pman0214/pytorch_jupyterlab
```

If you want to use CUDA, please run cuda version of the image. To use pytorch 1.9.0 with CUDA 11.1 with CuDNN 8, for example, run as:
```
docker run --rm -d -v $PWD:/app -p 8888:8888 --gpus=all pman0214/pytorch_jupyterlab:1.9.0-cuda11.1-cudnn8-devel
```

Please refer to [tags](https://hub.docker.com/r/pman0214/pytorch_jupyterlab/tags) to lookup images supporting CUDA. CUDA is available only on linux/amd64.

## Building

`Dockerfile` supports multi-architecture build for linux/amd64 and linux/arm64.
CUDA images are built with `Dockerfile_cuda`.

## Copyright, License

Copyright (c) 2021, Shigemi ISHIDA

* `Dockerfile` is released under the MIT license.
  See `LICENSE`.
