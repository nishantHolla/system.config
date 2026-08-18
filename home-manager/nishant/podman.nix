## podman settings and packages for nishant
{config, pkgs, ...}:

{
    services.podman.enable = true;

    home.packages = with pkgs; [
        podman-compose    # Implementation of docker-compose with podman backend
    ];
}
