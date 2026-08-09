## system packages for nixosVM
{ config, lib, pkgs, ... }:

{
    # System packages
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
        distrobox         # Wrapper around podman or docker to create and start containers
        git               # Distributed version control system
        htop              # Interactive process viewer
        podman-compose    # Implementation of docker-compose with podman backend
        vim               # Most popular clone of the VI editor
        wget              # Tool for retrieving files using HTTP, HTTPS, and FTP
        xsecurelock       # X11 screen lock utility with security in mind
    ];
}
