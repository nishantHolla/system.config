{ config, lib, pkgs, ... }:

{
  # System packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    xsecurelock
    htop
    vim
    wget
    xclip
  ];
}
