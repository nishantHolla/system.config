#!/bin/sh

set -euo pipefail
set -x

if command -v ueberzugpp &> /dev/null; then
	echo "ueberzugpp is already installed"
	exit 0
fi

sudo dnf config-manager addrepo --from-repofile=https://download.opensuse.org/repositories/home:justkidding/Fedora_44/home:justkidding.repo
sudo dnf install ueberzugpp
