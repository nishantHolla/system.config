#!/bin/sh

curl -L -o bw-linux.zip "https://bitwarden.com"
unzip bw-linux.zip
chmod u+x bw
mv bw $HOME/.local/bin/bw-cli
rm bw-linux.zip
