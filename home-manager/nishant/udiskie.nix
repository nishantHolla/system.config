## udiskie settings for nishnt
{ config, pkgs, ... }:

{
    services.udiskie = {
        enable = true;
        automount = true;
        tray = "auto";
    };
}
