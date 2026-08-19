## user packages for nishant
{ config, pkgs, ... }:

{
    # User Packages
    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
        # C/C++

        (lib.hiPrio clang)
        clang-tools                # Standalone command line tools for C++ development
        gcc                        # GNU Compiler Collection, version 14.2.1.20250322 (wrapper script)
        gdb                        # GNU Project debugger
        libgcc                     # GNU Compiler Collection, version 14.2.1.20250322

        # Lua

        lua5_1                     # Powerful, fast, lightweight, embeddable scripting language
        lua51Packages.luarocks     # A package manager for Lua modules.

        # Python

        pyright                    # Type checker for the Python language
        ruff                       # Extremely fast Python linter and code formatter
        uv                         # Extremely fast Python package installer and resolver, written in Rust

        (python313.withPackages (ps: with ps; [
            debugpy                # Implementation of the Debug Adapter Protocol for Python
            typer                  # Library for building CLI applications
        ]))

        # Rust

        cargo                      # Downloads your Rust project's dependencies and builds your project
        rust-analyzer              # Language server for the Rust language
        rustc                      # Safe, concurrent, practical language (wrapper script)

        # General

        acpi                       # Show battery status and other ACPI information
        alsa-utils                 # ALSA, the Advanced Linux Sound Architecture utils
        bat                        # Cat(1) clone with syntax highlighting and Git integration
        bibata-cursors             # Material Based Cursor Theme
        bitwarden-cli              # Secure and free password manager for all of your devices
        brightnessctl              # This program allows you read and control device brightness
        btop                       # Monitor of resources
        claude-code                # Agentic coding tool that lives in your terminal, understands your codebase, and helps you code faster
        dconf                      # Low level configuration system
        distrobox                  # Wrapper around podman or docker to create and start containers
        docker                     # Open source project to pack, ship and run any application as a lightweight container
        dragon-drop                # Simple drag-and-drop source/sink for X or Wayland (called dragon in upstream)
        eza                        # Modern, maintained replacement for ls
        fd                         # Simple, fast and user-friendly alternative to find
        ffmpegthumbnailer          # Lightweight video thumbnailer
        file                       # Program that shows the type of files
        firefox                    # Web browser built from Firefox source tree
        flameshot                  # Powerful yet simple to use screenshot software
        flowblade                  # Multitrack Non-Linear Video Editor
        font-manager               # Simple font management for GTK desktop environments
        fzf                        # Command-line fuzzy finder written in Go
        gimp3                      # GNU Image Manipulation Program
        git                        # Distributed version control system
        glow                       # Render markdown on the CLI, with pizzazz!
        gnumake                    # Tool to control the generation of non-source files from sources
        imagemagick                # Software suite to create, edit, compose, or convert bitmap images
        imv                        # Command line image viewer for tiling window managers
        inkscape                   # Vector graphics editor
        kdePackages.filelight      # Quickly visualize your disk space usage
        kdePackages.kdeconnect-kde # Multi-platform app that allows your devices to communicate
        lf                         # Terminal file manager written in Go and heavily inspired by ranger
        libreoffice-qt6            # Comprehensive, professional-quality productivity suite, a variant of openoffice.org
        mpv                        # General-purpose media player, fork of MPlayer and mplayer2
        neovim                     # Vim text editor fork focused on extensibility and agility
        networkmanagerapplet       # NetworkManager control applet for GNOME
        obs-studio                 # Free and open source software for video recording and live streaming
        p7zip                      # File compression and decompression tool
        papirus-icon-theme         # Pixel perfect icon theme for Linux
        pcmanfm                    # File manager with GTK interface
        picom                      # Fork of XCompMgr, a sample compositing manager for X servers
        playerctl                  # Command-line utility and library for controlling media players that implement MPRIS
        podman-compose             # Implementation of docker-compose with podman backend
        poppler-utils              # PDF rendering library
        qalculate-qt               # Ultimate desktop calculator
        ripgrep                    # Utility that combines the usability of The Silver Searcher with the raw speed of grep
        rofi                       # Window switcher, run dialog and dmenu replacement
        sops                       # Simple and flexible tool for managing secrets
        spotify                    # Play music from the Spotify music service
        starship                   # Minimal, blazing fast, and extremely customizable prompt for any shell
        tmux                       # Terminal multiplexer
        trashy                     # Simple, fast, and featureful alternative to rm and trash-cli
        tree-sitter                # Parser generator tool and an incremental parsing library
        udiskie                    # Removable disk automounter for udisks
        ueberzugpp                 # Drop in replacement for ueberzug written in C++
        unzip                      # Extraction utility for archives compressed in .zip format
        vimv-rs                    # Command line utility for batch-renaming files
        vscode                     # Code editor developed by Microsoft
        xclip                      # Tool to access the X clipboard from a console application
        xev                        # Log xserver events
        xsecurelock                # X11 screen lock utility with security in mind
        zathura                    # Highly customizable and functional PDF viewer
    ];
}
