#!/bin/sh

set -euo pipefail
set -x


sudo dnf install bluez bluez-tools blueman
sudo systemctl enable --now bluetooth.service
