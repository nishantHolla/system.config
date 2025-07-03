{ config, pkgs, ... }:

{
  # User Information
  home.username = "nishant";
  home.homeDirectory = "/home/nishant";

  # State Version
  home.stateVersion = "25.05";

  # Packages
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    acpi
    alacritty
    alsa-utils
    bat
    brightnessctl
    btop
    clang-tools
    dconf
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
    lxappearance
    mpv
    neovim
    networkmanagerapplet
    obs-studio
    p7zip
    pcmanfm
    playerctl
    poppler_utils
    qalculate-qt
    ripgrep
    rofi
    ruff
    starship
    spotify
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

  # dconf
  dconf.settings = {
    "org/gnome/nm-applet" = {
      "disable-connected-notifications" = true;
      "disable-disconnected-notifications" = true;
    };
  };

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
