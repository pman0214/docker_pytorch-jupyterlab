# Copyright (c) 2020, Shigemi ISHIDA
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

FROM pytorch/pytorch:1.7.0-cuda11.0-cudnn8-devel

ENV DEBIAN_FRONTEND=noninteractive

RUN set -x && \
	apt update && \
	apt install -y tzdata && \
	pip --no-cache-dir install seaborn jupyter jupyterlab scikit-learn imblearn statsmodels && \
	jupyter notebook --generate-config --allow-root && \
	ipython3 profile create

ENV JUPYTER_CONFIG=/root/.jupyter/jupyter_notebook_config.py \
    IPYTHON_CONFIG=/root/.ipython/profile_default/ipython_config.py
RUN : "generate jupyter config file" && { \
	echo "c.NotebookApp.ip = '0.0.0.0'"; \
	echo "c.NotebookApp.open_browser = False"; \
	echo "c.NotebookApp.password = \"sha1:b7c40958676d:fe82e5432ba0be429aa7391812c64d75c22194bc\""; \
	} | tee ${JUPYTER_CONFIG}
RUN : "generate ipython config file" && { \
	echo "c.InteractiveShellApp.exec_lines = ["; \
	echo "	'%autoreload 2',"; \
	echo "	'import numpy as np',"; \
	echo "	'import matplotlib.pyplot as plt',"; \
	echo "]"; \
	echo "c.InteractiveShellApp.extensions = ["; \
	echo "	'autoreload',"; \
	echo "]"; \
	} | tee -a ${IPYTHON_CONFIG}

VOLUME /root
WORKDIR /root

CMD ["jupyter", "lab", "--allow-root"]
