#!/bin/sh

set -euo pipefail
set -x

export GOPATH=$HOME/Go
INSTALL_DIR=$GOPATH/src/github.com/getsops/sops

if [ -d $INSTALL_DIR ]; then
	echo "sops is already installed"
	exit 0
fi

mkdir -p $INSTALL_DIR
git clone https://github.com/getsops/sops.git $INSTALL_DIR
make -C $INSTALL_DIR install

