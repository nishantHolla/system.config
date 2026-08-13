## home-manager for guest
{ config, pkgs, ... }:

{
    # User Information
    home.username = "guest";
    home.homeDirectory = "/home/guest";

    # Environment Variables
    home.sessionPath = [ "$SYSTEM_DIR/bin" ];
    home.sessionVariables = { SYSTEM_DIR = "$HOME/System"; };

    # State Version
    home.stateVersion = "26.05";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
