#!/bin/sh

# Copyright (c) 2021-2025, Shigemi ISHIDA
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

cd $(dirname $0) || exit 1

JUPYTER_CONFIG=/root/.jupyter/jupyter_notebook_config.py
IPYTHON_CONFIG=/root/.ipython/profile_default/ipython_config.py

set -x

pip3 --no-cache-dir install lightning seaborn jupyter jupyterlab scikit-learn imblearn statsmodels || exit 1
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
