#!/bin/sh

sudo dnf config-manager addrepo --from-repofile=https://download.opensuse.org/repositories/home:justkidding/Fedora_44/home:justkidding.repo
sudo dnf install ueberzugpp
