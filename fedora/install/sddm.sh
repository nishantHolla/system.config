#!/bin/sh

set -euo pipefail
set -x

sudo dnf install sddm qt6-qtsvg qt6-qtvirtualkeyboard qt6-qtmultimedia
sudo systemctl enable sddm.service
sudo systemctl set-default graphical.target

if [ ! -d /usr/share/sddm/themes/sddm-astronaut-theme ]; then
	sudo git clone -b master --depth 1 https://github.com/keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme
	sudo cp -r /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/
	echo "[Theme]
Current=sddm-astronaut-theme" | sudo tee /etc/sddm.conf
	echo "[General]
InputMethod=qtvirtualkeyboard" | sudo tee /etc/sddm.conf.d/virtualkbd.conf
fi
