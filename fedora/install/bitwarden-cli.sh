#!/bin/sh

set -euo pipefail
set -x

if command -v bw-cli &> /dev/null; then
	echo "bitwarden cli is already installed"
	exit 0
fi

INSTALL_FILE=$HOME/.local/bin/bw-cli

curl -L -o bw-linux.zip "https://bitwarden.com/download/?app=cli&platform=linux"
unzip bw-linux.zip
chmod u+x bw
mv bw $INSTALL_FILE
rm bw-linux.zip
