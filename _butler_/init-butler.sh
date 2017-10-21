#!/bin/bash

# RUN ME WITH:
#   . ./init-butler.sh
# OR WITH:
#   source ./init-butler.sh


export PATH=$(pwd):$PATH

# export PATH="$PATH:$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "PATH: $PATH"

export BUTLER_PATH=$(pwd)

echo "BUTLER_PATH: $BUTLER_PATH"