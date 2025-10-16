## home-manager for nishant
{ config, pkgs, ... }:

{
  # User Information
  home.username = "nishant";
  home.homeDirectory = "/home/nishant";

  # State Version
  home.stateVersion = "25.05";

  # Environment Variables
  home.sessionPath = [
    "$HOME/System/bin"
  ];

  home.sessionVariables = {
    # System

    SYSTEM_DIR = "$HOME/System";

    # XDG Paths

    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_DATA_HOME = "$HOME/.local/share";

    # GTK

    XCURSOR_THEME = "Bibata-Modern-Classic";

    # Applications

    EDITOR = "nvim";
    TERMINAL = "alacritty";
    BROWSER = "firefox";
    FILE_MANAGER = "pcmanfm";
    CLI_FILE_MANAGER = "lf";
    PDF_VIEWER = "zathura";
    IMAGE_VIEWER = "vimiv";
    VIDEO_VIEWER = "mpv";
    WORD_EDITOR = "wps";
    PRESENTATION_EDITOR = "wpp";
    SPREADSHEET_EDITOR = "et";

    # xsecurelock

    XSECURELOCK_BLANK_DPMS_STATE = "off";
    XSECURELOCK_FONT = "Inconsolata LGC Nerd Font Mono";
    XSECURELOCK_SHOW_DATETIME = "1";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
