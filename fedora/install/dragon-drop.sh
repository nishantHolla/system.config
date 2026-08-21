#!/bin/sh

set -euo pipefail
set -x

if command -v dragon &> /dev/null; then
	echo "dragon is already installed"
	exit 0
fi

mkdir -p $HOME/Software
git clone https://github.com/mwh/dragon $HOME/Software/dragon
make -C $HOME/Software/dragon PREFIX=$HOME/.local/bin
