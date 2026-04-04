## system packages for nixosVM
{ config, lib, pkgs, ... }:

{
  # System packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    git
    htop
    vim
    wget
    xsecurelock
  ];
}
