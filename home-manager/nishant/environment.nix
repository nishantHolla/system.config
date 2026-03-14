## user environment variables for nishant
{ config, pkgs, ...}:

{

  home.sessionPath = [
    "$SYSTEM_DIR/bin"
    "$CARGO_HOME/bin"
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
    IMAGE_VIEWER = "imv";
    VIDEO_VIEWER = "mpv";
    WORD_EDITOR = "libreoffice";
    PRESENTATION_EDITOR = "libreoffice";
    SPREADSHEET_EDITOR = "libreoffice";
    MANPAGER = "nvim +Man!";

    # fd

    FD_IGNORE = "$XDG_CONFIG_HOME/fd/ignore";

    # fzf

    FZF_KEYBINDINGS = "alt-j:down,alt-k:up,alt-l:accept,alt-h:cancel";
    FZF_DEFAULT_OPTS = "--bind=alt-j:down,alt-k:up,alt-l:accept,alt-h:cancel";

    # git

    GIT_CONFIG_GLOBAL = "$XDG_CONFIG_HOME/git/.gitconfig";

    # rust

    RUSTUP_HOME = "$XDG_CONFIG_HOME/rustup";
    CARGO_HOME = "$XDG_CONFIG_HOME/cargo";

    # starship

    STARSHIP_CONFIG = "$XDG_CONFIG_HOME/starship/starship.toml";

    # xsecurelock

    XSECURELOCK_BLANK_DPMS_STATE = "off";
    XSECURELOCK_FONT = "Inconsolata LGC Nerd Font Mono";
    XSECURELOCK_SHOW_DATETIME = "1";

    # zsh

    ZDOTDIR = "$XDG_CONFIG_HOME/zsh";
  };
}
