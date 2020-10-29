#!/bin/bash

set -x

STARTDIR=$PWD

mkdir -p $HOME/sklearn_iris_test
pushd $HOME/sklearn_iris_test

# create python environment
echo `conda --version`  # 4.8.5

CONDA_BASE=$(conda info --base)

conda create -n tfx_024_iris_sklearn python=3.7 -y

source $CONDA_BASE/etc/profile.d/conda.sh

conda activate tfx_024_iris_sklearn

# Show what's in our environment
conda env export > $STARTDIR/environment.yml

pip install -U pip
pip install -i https://pypi-nightly.tensorflow.org/simple tfx

pip install scikit-learn numpy --use-feature=2020-resolver

pip freeze > $STARTDIR/requirements.txt

# Get a fresh copy of TFX, go to a recent tag
git clone https://github.com/tensorflow/tfx.git tfx-source
pushd tfx-source
git checkout tags/v0.24.1
popd


popd
set +x
