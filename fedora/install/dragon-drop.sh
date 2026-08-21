#!/bin/sh

mkdir -p $HOME/Software
git clone https://github.com/mwh/dragon $HOME/Sofware
make -C $HOME/Software/dragon PREFIX=$HOME/.local/bin
