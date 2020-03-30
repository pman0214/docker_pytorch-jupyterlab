# pytorch + Jupyterlab

## Overview

* Docker image based on `pytorch/pytorch:1.2-cuda10.0-cudnn7-devel`.
* Installs python libraries below:
  * seaborn
  * jupyter
  * jupyterlab (password: jupyter)
  * scikit-learn
  * imblearn
  * statsmodels
* Also provides sample `docker-compose.yml` files.

## Copyright, License

Copyright (c) 2020, Shigemi ISHIDA

* `Dockerfile` is released under the BSD 3-clause license.
  See `LICENSE_BSD-3Clause`.
* `docker-compose.yml` and `docker-compose_nvidia.yml` are released
  under the MIT license.
  See `LICENSE_MIT`.
