#!/bin/sh

set -euo pipefail
set -x

wget "https://repo.protonvpn.com/fedora-$(cat /etc/fedora-release | cut -d' ' -f 3)-stable/protonvpn-stable-release/protonvpn-stable-release-1.0.4-1.noarch.rpm"
sudo dnf install ./protonvpn-stable-release-1.0.rpm && sudo dnf check-update --refresh
sudo dnf install proton-vpn-cli
