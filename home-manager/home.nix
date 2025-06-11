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
    alsa-utils
    bat
    brightnessctl
    btop
    clang-tools
    dragon-drop
    docker_28
    fd
    file
    firefox
    flameshot
    flowblade
    font-manager
    fzf
    gcc
    gimp3
    git
    glow
    inkscape
    kdePackages.kdeconnect-kde
    lf
    libgcc
    libreoffice-qt6
    mpv
    neovim
    obs-studio
    p7zip
    pcmanfm
    playerctl
    poppler_utils
    qalculate-qt
    ripgrep
    rofi
    starship
    tmux
    trash-cli
    ueberzugpp
    virtualbox
    vimiv-qt
    vimv-rs
    zathura
  ];

  # Programs and services
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
    unalias -m "*"
    source $XDG_CONFIG_HOME/zsh/zshrc
    '';
  };

  # services.picom.enable = true;

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

    # Applications

    EDITOR = "nvim";
    TERMINAL = "alacritty";
    BROWSER = "firefox";
    FILE_MANAGER = "pcmanfm";
    CLI_FILE_MANAGER = "lf";
    PDF_VIEWER = "zathura";
    IMAGE_VIEWER = "vimiv";
    VIDEO_VIEWER = "mpv";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
