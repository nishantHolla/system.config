#!/bin/sh

set -euo pipefail
set -x

sudo dnf install xorg-x11-server-Xorg xorg-x11-xinit xorg-x11-drv-libinput awesome
sudo dnf install xorg-x11-xauth xorg-x11-xinit
