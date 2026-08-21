#!/bin/sh

set -euo pipefail
set -x

mkdir -p $HOME/Software
git clone https://github.com/mwh/dragon $HOME/Software/dragon
make -C $HOME/Software/dragon PREFIX=$HOME/.local/bin
