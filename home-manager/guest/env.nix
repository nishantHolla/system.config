# environment variables for nishant
{ config, pkgs, ... }:

{
    home.sessionPath = [
        "$SYSTEM_DIR/bin"
        "$HOME/.local/bin"
        "$CARGO_HOME/bin"
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
        IMAGE_VIEWER = "imv";
        VIDEO_VIEWER = "mpv";
        WORD_EDITOR = "libreoffice";
        PRESENTATION_EDITOR = "libreoffice";
        SPREADSHEET_EDITOR = "libreoffice";
        MANPAGER = "nvim +Man!";

        # fd

        FD_IGNORE = "${config.home.sessionVariables.XDG_CONFIG_HOME}/fd/ignore";

        # fzf

        FZF_KEYBINDINGS = "alt-j:down,alt-k:up,alt-l:accept,alt-h:cancel,alt-space:toggle";
        FZF_DEFAULT_OPTS = ''
    --bind=${config.home.sessionVariables.FZF_KEYBINDINGS}
    --color bg:#080808
    --color bg+:#262626
    --color border:#2e2e2e
    --color fg:#b2b2b2
    --color fg+:#e4e4e4
    --color gutter:#262626
    --color header:#80a0ff
    --color hl+:#f09479
    --color hl:#f09479
    --color info:#cfcfb0
    --color marker:#f09479
    --color pointer:#ff5189
    --color prompt:#80a0ff
    --color spinner:#36c692
        '';

        # git

        GIT_CONFIG_GLOBAL = "${config.home.sessionVariables.XDG_CONFIG_HOME}/git/config";

        # rust

        RUSTUP_HOME = "${config.home.sessionVariables.XDG_CONFIG_HOME}/rustup";
        CARGO_HOME = "${config.home.sessionVariables.XDG_CONFIG_HOME}/cargo";

        # starship

        STARSHIP_CONFIG = "${config.home.sessionVariables.XDG_CONFIG_HOME}/starship/starship.toml";

        # sops

        SOPS_AGE_KEY_FILE = "$HOME/Sops/age/keys.txt";
    };
}
