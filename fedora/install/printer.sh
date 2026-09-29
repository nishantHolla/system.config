#!/bin/sh

sudo dnf install hplip hplip-gui
sudo systemctl --now enable cups
