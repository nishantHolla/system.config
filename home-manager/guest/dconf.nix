## dconf settings for guest
{ config, pkgs, ... }:

{
    dconf.settings = {
        "org/gnome/nm-applet" = {
            "disable-connected-notifications" = true;
            "disable-disconnected-notifications" = true;
        };
        "org/virt-manager/virt-manager/connections" = {
            autoconnect = [ "qemu:///system" ];
            uris = [ "qemu:///system" ];
        };
    };
}
