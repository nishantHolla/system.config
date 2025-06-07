{ config, pkgs, ... }:

{
  # User Information
  home.username = "nishant";
  home.homeDirectory = "/home/nishant";

  # State Version
  home.stateVersion = "25.05";

  # Packages
  home.packages = with pkgs; [
    alacritty
    bat
    btop
    clang-tools
    dragon-drop
    fd
    firefox
    flameshot
    fzf
    gcc
    git
    glow
    lf
    libgcc
    neovim
    p7zip
    poppler_utils
    starship
    tmux
    trash-cli
    ueberzugpp
    vimv-rs
    zathura
  ];

  # Programs
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
    unalias -m "*"
    source $XDG_CONFIG_HOME/zsh/zshrc
    '';
  };

  # Environment Variables
  home.sessionVariables = {
    # System

    SYSTEM_DIR = "$HOME/System";

    # XDG Paths

    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_DATA_HOME = "$HOME/.local/share";

    # Applications

    EDITOR = "nvim";
    TERMINAL = "alacritty";
    BROWSER = "firefox";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
