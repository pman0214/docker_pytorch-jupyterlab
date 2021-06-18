# pytorch + Jupyterlab

## Overview

* Pytorch + Jupyter Docker image based on [python docker image](https://hub.docker.com/_/python).

This image is built with these installation processes.
* Follows pytorch installation procedure on [pytorch official page](https://pytorch.org).
* Installs python modules:
  * seaborn
  * jupyter
  * jupyterlab (password: jupyter)
  * scikit-learn
  * imblearn
  * statsmodels

Jupyterlab's password is `jupyter`.

## Usage

Run with port opened on 8888. Default workdir is `/app`.
```
docker run --rm -d -v $PWD:/app -p 8888:8888 pman0214/pytorch_jupyterlab
```

If you want to use CUDA, please run cuda version of the image. For example, if you want to use pytorch 1.9.0 with CUDA 11.1 with CuDNN 8,
```
docker run --rm -d -v $PWD:/app -p 8888:8888 --gpus=all pman0214/pytorch_jupyterlab:1.9.0-cuda11.1-cudnn8-devel
```

## Copyright, License

Copyright (c) 2021, Shigemi ISHIDA

* `Dockerfile` is released under the MIT license.
  See `LICENSE`.
