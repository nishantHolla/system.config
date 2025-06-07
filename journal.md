# System Journal

## Setup

- Setup partition using `fdisk`
    - `BOOT`: 1GB FAT 32
    - `swap`: 8GB Linux Swap
    - `nixos`: nGB Linux Filesystem

- Setup LUKS encryption on `nixos` partition

- Continue with installation and add `git` and `firefox`

- Setup SSH key and add to github

- Clone `System` repository

- Copy current system's `hardware-configuration.nix` to `~/System/nixos/hardware`

- Edit `~/System/nixos/flake.nix` to add the current system's section

- Rebuild switch nixos

- Setup home-manager

- Rebuild switch home manager

- Run `link.sh` script

## Tmux

- Launch terminal and press `prefix + I` to install plugins
