## user packages for guest
{ config, pkgs, ... }:

{
    # User Packages
    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
        acpi                       # Show battery status and other ACPI information
        alsa-utils                 # ALSA, the Advanced Linux Sound Architecture utils
        bat                        # Cat(1) clone with syntax highlighting and Git integration
        bibata-cursors             # Material Based Cursor Theme
        brightnessctl              # This program allows you read and control device brightness
        btop                       # Monitor of resources
        dconf                      # Low level configuration system
        docker                     # Open source project to pack, ship and run any application as a lightweight container
        dragon-drop                # Simple drag-and-drop source/sink for X or Wayland (called dragon in upstream)
        eza                        # Modern, maintained replacement for ls
        fd                         # Simple, fast and user-friendly alternative to find
        ffmpegthumbnailer          # Lightweight video thumbnailer
        file                       # Program that shows the type of files
        firefox                    # Web browser built from Firefox source tree
        font-manager               # Simple font management for GTK desktop environments
        fzf                        # Command-line fuzzy finder written in Go
        git                        # Distributed version control system
        glow                       # Render markdown on the CLI, with pizzazz!
        gnumake                    # Tool to control the generation of non-source files from sources
        imagemagick                # Software suite to create, edit, compose, or convert bitmap images
        imv                        # Command line image viewer for tiling window managers
        lf                         # Terminal file manager written in Go and heavily inspired by ranger
        mpv                        # General-purpose media player, fork of MPlayer and mplayer2
        neovim                     # Vim text editor fork focused on extensibility and agility
        networkmanagerapplet       # NetworkManager control applet for GNOME
        p7zip                      # File compression and decompression tool
        papirus-icon-theme         # Pixel perfect icon theme for Linux
        playerctl                  # Command-line utility and library for controlling media players that implement MPRIS
        poppler-utils              # PDF rendering library
        ripgrep                    # Utility that combines the usability of The Silver Searcher with the raw speed of grep
        rofi                       # Window switcher, run dialog and dmenu replacement
        sops                       # Simple and flexible tool for managing secrets
        starship                   # Minimal, blazing fast, and extremely customizable prompt for any shell
        tmux                       # Terminal multiplexer
        trashy                     # Simple, fast, and featureful alternative to rm and trash-cli
        tree-sitter                # Parser generator tool and an incremental parsing library
        ueberzugpp                 # Drop in replacement for ueberzug written in C++
        unzip                      # Extraction utility for archives compressed in .zip format
        vimv-rs                    # Command line utility for batch-renaming files
        xclip                      # Tool to access the X clipboard from a console application
        xev                        # Log xserver events
        zathura                    # Highly customizable and functional PDF viewer
    ];
}
