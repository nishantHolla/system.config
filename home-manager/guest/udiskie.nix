## udiskie settings for guest
{ config, pkgs, ... }:

{
    services.udiskie = {
        enable = true;
        automount = true;
        tray = "auto";
    };
}
