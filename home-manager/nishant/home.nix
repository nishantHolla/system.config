## home-manager for nishant
{ config, pkgs, ... }:

{
    # User Information
    home.username = "nishant";
    home.homeDirectory = "/home/nishant";

    # State Version
    home.stateVersion = "25.05";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
