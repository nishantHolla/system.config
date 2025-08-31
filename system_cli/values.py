from pathlib import Path

## Paths

SYSTEM_CLI_DIR = Path(__file__).parent
SYSTEM_DIR = SYSTEM_CLI_DIR.parent
SYSTEM_CONFIG_DIR = SYSTEM_DIR / "config"

NIXOS_DIR = SYSTEM_DIR / "nixos"
NIXOS_TEMPLATE_DIR = NIXOS_DIR / "template"
NIXOS_FLAKE_FILE = NIXOS_DIR / "flake.nix"

HOME_MANAGER_DIR = SYSTEM_DIR / "home-manager"
SYSTEM_FONTS_DIR = Path("~/.local/share/fonts").expanduser()
HOME_FONTS_DIR = Path("~/Fonts").expanduser()
SYSTEM_ICONS_DIR = Path("~/.local/share/icons").expanduser()
HOME_ICONS_DIR = Path("~/Icons").expanduser()
HOME_WALLPAPERS_DIR = Path("~/Wallpapers").expanduser()
AWESOME_DIR = Path("~/.local/share/awesome").expanduser()

## Usage

SYSTEM_USAGE = """
Usage: system <command> <sub-command> [...arguments]

command:

    help:

        Print help message and exit.

    nixos:

        Control system-level configuration
"""

NIXOS_USAGE = """
Usage: system nixos <sub-command> [...arguments]

sub-command:

    help:

        Print help message and exit.

    setup:

        Perform setup actions for the system.
        Run only once for a new system.

"""

HOME_USAGE = """
Usage: system home <sub-command> [...arguments]

sub-command:

    help:

        Print help message and exit.

    setup:

        Perform setup actions for the home.
        Run only once for a new system.

    switch:

        Switch to new configuration by rebuilding using home-manager.
"""
