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
    bibata-cursors
    brightnessctl
    btop
    clang-tools
    dconf
    docker_28
    dragon-drop
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
    networkmanagerapplet
    obs-studio
    p7zip
    papirus-icon-theme
    pcmanfm
    playerctl
    poppler_utils
    qalculate-qt
    ripgrep
    rofi
    ruff
    spotify
    starship
    tmux
    trash-cli
    ueberzugpp
    vimiv-qt
    vimv-rs
    virtualbox
    xorg.xev
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

  # GTK
  gtk = {
    enable = true;

    theme = {
      name = "Adwaita-dark";
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
  };

  xresources.properties = {
    "Xcursor.theme" = "Bibata-Modern-Classic";
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
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
