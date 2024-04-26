# pytorch + Jupyterlab

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Table of Contents
- [pytorch + Jupyterlab](#pytorch--jupyterlab)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Simple Usage](#simple-usage)
  - [Building](#building)
  - [Check installed version](#check-installed-version)
  - [Copyright, License](#copyright-license)

## Overview

Pytorch + Jupyter Docker image based on [python docker image](https://hub.docker.com/_/python).

LaTeX support version (for EPS/PDF plotting) is also available at https://hub.docker.com/r/pman0214/pytorch_jupyterlab_latex.

Source code is available [on GitHub](https://github.com/pman0214/docker_pytorch-jupyterlab).
Docker images are available for x86_64 (amd64) and aarch64 (arm64) [on Docker Hub](https://hub.docker.com/r/pman0214/pytorch_jupyterlab), which are automatically built with GitHub Actions. The CUDA version is only available for x86_64 (amd64).

This image is built by:
* Following pytorch installation instructions on [pytorch official page](https://pytorch.org).
  * torch, torchvision, and torchaudio are installed.
  * For CUDA version of the image, [pytorch/pytorch](https://hub.docker.com/r/pytorch/pytorch) image is used instead of installing pytorch.
* Installing python modules:
  * seaborn
  * jupyter
  * jupyterlab
  * scikit-learn
  * imblearn
  * statsmodels

Jupyterlab's password is `jupyter`.

## Simple Usage

1. Pull the latest docker image.
```
docker pull pman0214/pytorch_jupyterlab
```
1. Create a docker container with the volume on `/app` and with the port opened on `8888`.
```
docker run -d --rm -v $PWD:/app -p 8888:8888 pman0214/pytorch_jupyterlab
```
1. Access http://localhost:8888/ with your browser.
1. Enter password `jupyter` to login and enjoy!
1. Shutdown jupyterlab from the `File` menu to stop and destroy the container.

The CUDA version of the image is provided with the tag `latest-gpu`. Please don't forget to specify the `gpus` option:
```
docker run --rm -d -v $PWD:/app -p 8888:8888 --gpus=all pman0214/pytorch_jupyterlab:latest-gpu
```

Please refer to [tags](https://hub.docker.com/r/pman0214/pytorch_jupyterlab/tags) to find other versions.

## Building

`Dockerfile` supports multi-architecture build for linux/amd64 and linux/arm64.
The CUDA version of the image is built with `Dockerfile_cuda`.

## Check installed version

Run these on jupyter.

```
import torch
import torchvision
import torchaudio
print(torch.__version__)
print(torchvision.__version__)
print(torchaudio.__version__)

import numpy as np
import scipy as sp
import pandas as pd
import matplotlib as mpl
import seaborn as sns
import sklearn
import imblearn
import statsmodels
print(np.__version__)
print(sp.__version__)
print(pd.__version__)
print(mpl.__version__)
print(sns.__version__)
print(sklearn.__version__)
print(imblearn.__version__)
print(statsmodels.__version__)

# GPU check (comment out with CPU image)
print(torch.cuda.is_available())
print(torch.cuda.device_count())
print(torch.cuda.get_device_name(0))
print(torch.cuda.get_device_capability(0))
```

## Copyright, License

Copyright (c) 2021-2024, Shigemi ISHIDA

`Dockerfile` and `Dockerfile_cuda` are released under the MIT license.
See `LICENSE`.
