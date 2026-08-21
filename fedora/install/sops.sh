#!/bin/sh

mkdir -p $GOPATH/src/github.com/getsops/sops/
git clone https://github.com/getsops/sops.git $GOPATH/src/github.com/getsops/sops/
cd $GOPATH/src/github.com/getsops/sops/
make install

