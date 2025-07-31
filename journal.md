# System Journal

## Setup

- Setup partition using `fdisk`
    - `BOOT`: 1GB FAT 32
    - `swap`: 8GB Linux Swap
    - `nixos`: nGB Linux Filesystem

- Setup LUKS encryption on `nixos` partition

- Clone `System` repository

- Setup current system's nixos config

- Edit `~/System/nixos/flake.nix` to add the current system's section

- Install nixos with `nixos-install --flake .#<system-name>`

- Setup SSH key and add to github

- Install home-manager with `nix run home-manager/master -- switch --flake .#<user-name>`

- Run `setup.sh` script

- Run `link.sh` script

## Tmux

- Launch terminal and press `prefix + I` to install plugins

## AwesomeWM

- Create directory `$HOME/.local/share/awesome`
