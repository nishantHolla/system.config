from pathlib import Path

# Paths

SYSTEM_CLI_DIR = Path(__file__).parent
SYSTEM_DIR = SYSTEM_CLI_DIR.parent

NIXOS_DIR = SYSTEM_DIR / "nixos"
NIXOS_TEMPLATE_DIR = NIXOS_DIR / "template"
NIXOS_FLAKE_FILE = NIXOS_DIR / "flake.nix"

HOME_MANAGER_DIR = SYSTEM_DIR / "home-manager"

# Usage

SYSTEM_USAGE = """
Usage: system <command> <sub-command> [...arguments]

command:

    help:

        Print help message and exit.

    nixos:

        Control system-level configurations.

    home:

        Control home-level configurations.
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

        Perform setup actions the home.
        Run only once for a new system.
"""
