## system packages for nixosVM
{ config, lib, pkgs, ... }:

{
  # System packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    distrobox
    docker-compose
    git
    htop
    vim
    wget
    xsecurelock
  ];
}
