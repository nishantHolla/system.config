## system packages for nixosPavilion
{ config, lib, pkgs, ... }:

{
    # System packages
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
        dnsmasq           # Integrated DNS, DHCP and TFTP server for small networks
        git               # Distributed version control system
        htop              # Interactive process viewer
        vim               # Most popular clone of the VI editor
        wget              # Tool for retrieving files using HTTP, HTTPS, and FTP
    ];
}
