## home-manager for nishant
{ config, pkgs, ... }:

{
    # User Information
    home.username = "nishant";
    home.homeDirectory = "/home/nishant";

    # Environment Variables
    home.sessionPath = [ "$SYSTEM_DIR/bin" ];
    home.sessionVariables = { SYSTEM_DIR = "$HOME/System"; };

    # State Version
    home.stateVersion = "26.05";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
    targets.genericLinux.enable = true;
}
