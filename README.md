# pytorch + Jupyterlab

## Overview

Pytorch + Jupyter Docker image based on [python docker image](https://hub.docker.com/_/python).

This image is built as:
* Follows pytorch installation instructions on [pytorch official page](https://pytorch.org).
  * For CUDA version of the image, [pytorch/pytorch](https://hub.docker.com/r/pytorch/pytorch) image is used instead of installing pytorch.
* Installs python modules:
  * seaborn
  * jupyter
  * jupyterlab
  * scikit-learn
  * imblearn
  * statsmodels

Jupyterlab's password is `jupyter`.

## Simple Usage

1. Pull this docker image. Please refer to [tags](https://hub.docker.com/r/pman0214/pytorch_jupyterlab/tags) to check available versions.
```
docker pull pman0214/pytorch_jupyterlab:version
```
1. Create a docker container with volume on `/app` and with port opened on `8888`.
```
docker run -d --rm -v $PWD:/app -p 8888:8888 pman0214/pytorch_jupyterlab:version
```
1. Access http://localhost:8888/ with your browser.
1. Enter password `jupyter` to login and enjoy!
1. Shutdown jupyterlab from the `File` menu to stop and destroy the container.


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

`Dockerfile` and `Dockerfile_cuda` are released under the MIT license.
See `LICENSE`.
