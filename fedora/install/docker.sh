#!/bin/sh

set -euo pipefail
set -x

if command -v docker &> /dev/null; then
	echo "docker is already installed"
	exit 0
fi

sudo dnf install dnf-plugins-core
sudo dnf config-manager addrepo --from-repofile https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
