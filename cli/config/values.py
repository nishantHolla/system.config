from pathlib import Path

## Values

BITWARDEN_SERVER_URL = "https://vault.bitwarden.eu"
BITWARDEN_SSH_KEY_NOTE_NAME = "GithubSSH"
BITWARDEN_GPG_PUBLIC_KEY_NOTE_NAME = "GithubGPG-Public"
BITWARDEN_GPG_PRIVATE_KEY_NOTE_NAME = "GithubGPG-Private"

SYSTEM_REPO_URL = "git@github.com:nishantHolla/system.config.git"
FONTS_REPO_URL = "git@github.com:nishantHolla/fonts.git"
ICONS_REPO_URL = "git@github.com:nishantHolla/icons.git"
WALLPAPERS_REPO_URL = "git@github.com:nishantHolla/wallpapers.git"

## Paths

SYSTEM_CLI_DIR = Path(__file__).parent.parent
SYSTEM_DIR = SYSTEM_CLI_DIR.parent
SYSTEM_CONFIG_DIR = SYSTEM_DIR / "config"

NIXOS_DIR = SYSTEM_DIR / "nixos"
NIXOS_TEMPLATE_DIR = NIXOS_DIR / "template"
NIXOS_FLAKE_FILE = NIXOS_DIR / "flake.nix"

HOME_MANAGER_DIR = SYSTEM_DIR / "home-manager"
HOME_FONTS_DIR = Path("~/Fonts").expanduser()
HOME_ICONS_DIR = Path("~/Icons").expanduser()
HOME_WALLPAPERS_DIR = Path("~/Wallpapers").expanduser()

SYSTEM_FONTS_DIR = Path("~/.local/share/fonts").expanduser()
SYSTEM_ICONS_DIR = Path("~/.local/share/icons").expanduser()

AWESOME_DIR = Path("~/.local/share/awesome").expanduser()

## Help

SYSTEM_TYPER_HELP_STR = "CLI for System"

NIXOS_TYPER_HELP_STR = "Control system-level configuration"
NIXOS_TYPER_HELP = {
    "setup": "Perform setup actions for the system",
    "switch": "Switch to new configuration by rebuilding using nixos",
}

HOME_TYPER_HELP_STR = "Control home-manager level configuration"
HOME_TYPER_HELP = {
    "setup": "Perform setup actions for the user",
    "switch": "Switch to new configuration by rebuilding using home-manager",
}
