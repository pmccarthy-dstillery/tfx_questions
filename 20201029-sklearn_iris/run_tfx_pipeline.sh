#!/bin/bash

set -x

pushd $HOME/sklearn_iris_test

CONDA_BASE=$(conda info --base)

source $CONDA_BASE/etc/profile.d/conda.sh

conda activate tfx_024_iris_sklearn

cp -r tfx-source/tfx/examples/iris $HOME/

python $HOME/iris/experimental/iris_pipeline_sklearn_local.py

popd

set +x