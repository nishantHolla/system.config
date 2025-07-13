{ config, pkgs, ... }:

{
  dconf.settings = {
    "org/gnome/nm-applet" = {
      "disable-connected-notifications" = true;
      "disable-disconnected-notifications" = true;
    };
  };
}
