## system packages for nixosVM
{ config, lib, pkgs, ... }:

{
  # System packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    distrobox
    git
    htop
    podman-compose
    vim
    wget
    xsecurelock
  ];
}
