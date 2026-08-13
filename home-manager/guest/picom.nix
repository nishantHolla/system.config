## picom settings for guest
{ config, pkgs, ... }:

{
    services.picom = {
        enable = true;
        vSync = true;
    };
}
