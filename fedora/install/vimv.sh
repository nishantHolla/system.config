#!/bin/sh

set -euo pipefail
set -x

if command -v vimv &> /dev/null; then
	echo "vimv is already installed"
	exit 0
fi

curl https://raw.githubusercontent.com/thameera/vimv/master/vimv > ~/.local/bin/vimv && chmod +755 ~/.local/bin/vimv
