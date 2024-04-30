#!/bin/sh

# Copyright (c) 2021-2024, Shigemi ISHIDA
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

CUDA_TARGETS="torch==2.3.0+cu121
torchvision==0.18.0+cu121
torchaudio==2.3.0+cu121"
TARGETS=""

case $(arch) in
    aarch64|arm64)
        ;;
    x86_64|amd64)
        # build for cpu
        lines=$(echo "${CUDA_TARGETS}" | cut -d'+' -f1 | while read line; do
            echo $line+cpu
        done)
        CUDA_TARGETS=$lines
        ;;
    *)
        exit 1
esac

set -x

pip3 install ${CUDA_TARGETS} ${TARGETS} -f https://download.pytorch.org/whl/torch_stable.html || exit 1
