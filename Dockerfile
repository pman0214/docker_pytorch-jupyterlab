# 
# Copyright (c) 2020, Shigemi ISHIDA
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. Neither the name of the Institute nor the names of its contributors
#    may be used to endorse or promote products derived from this software
#    without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE INSTITUTE AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE INSTITUTE OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.

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
