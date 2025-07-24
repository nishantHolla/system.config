## user packages for nishant
{ config, pkgs, ... }:

{
  # User Packages
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    acpi                       # Show battery status and other ACPI information
    alacritty                  # Cross-platform, GPU-accelerated terminal emulator
    alsa-utils                 # ALSA, the Advanced Linux Sound Architecture utils
    bat                        # Cat(1) clone with syntax highlighting and Git integration
    bibata-cursors             # Material Based Cursor Theme
    brightnessctl              # This program allows you read and control device brightness
    btop                       # Monitor of resources
    clang-tools                # Standalone command line tools for C++ development
    dconf                      # Low level configuration system
    docker_28                  # Open source project to pack, ship and run any application as a lightweight container
    dragon-drop                # Simple drag-and-drop source/sink for X or Wayland (called dragon in upstream)
    fd                         # Simple, fast and user-friendly alternative to find
    file                       # Program that shows the type of files
    firefox                    # Web browser built from Firefox source tree
    flameshot                  # Powerful yet simple to use screenshot software
    flowblade                  # Multitrack Non-Linear Video Editor
    font-manager               # Simple font management for GTK desktop environments
    fzf                        # Command-line fuzzy finder written in Go
    gcc                        # GNU Compiler Collection, version 14.2.1.20250322 (wrapper script)
    gimp3                      # GNU Image Manipulation Program
    git                        # Distributed version control system
    glow                       # Render markdown on the CLI, with pizzazz!
    inkscape                   # Vector graphics editor
    kdePackages.filelight      # Quickly visualize your disk space usage
    kdePackages.kdeconnect-kde # Multi-platform app that allows your devices to communicate
    lf                         # Terminal file manager written in Go and heavily inspired by ranger
    libgcc                     # GNU Compiler Collection, version 14.2.1.20250322
    libreoffice-qt6            # Comprehensive, professional-quality productivity suite, a variant of openoffice.org
    mpv                        # General-purpose media player, fork of MPlayer and mplayer2
    neovim                     # Vim text editor fork focused on extensibility and agility
    networkmanagerapplet       # NetworkManager control applet for GNOME
    obs-studio                 # Free and open source software for video recording and live streaming
    p7zip                      # File compression and decompression tool
    papirus-icon-theme         # Pixel perfect icon theme for Linux
    pcmanfm                    # File manager with GTK interface
    playerctl                  # Command-line utility and library for controlling media players that implement MPRIS
    python313                  # High-level dynamically-typed programming language
    poppler_utils              # PDF rendering library
    qalculate-qt               # Ultimate desktop calculator
    ripgrep                    # Utility that combines the usability of The Silver Searcher with the raw speed of grep
    rofi                       # Window switcher, run dialog and dmenu replacement
    ruff                       # Extremely fast Python linter and code formatter
    spotify                    # Play music from the Spotify music service
    starship                   # Minimal, blazing fast, and extremely customizable prompt for any shell
    tmux                       # Terminal multiplexer
    trash-cli                  # Command line interface to the freedesktop.org trashcan
    ueberzugpp                 # Drop in replacement for ueberzug written in C++
    vimiv-qt                   # Image viewer with Vim-like keybindings (Qt port)
    vimv-rs                    # Command line utility for batch-renaming files
    virtualbox                 # PC emulator
    xorg.xev                   # Log xserver events
    zathura                    # Highly customizable and functional PDF viewer
  ];
}
