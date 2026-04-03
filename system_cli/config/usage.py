SYSTEM_USAGE = """
Usage: system <command> <sub-command> [...arguments]

command:

    help:

        Print help message and exit.

    nixos:

        Control system-level configuration

    home:

        Control home-manager level configuration
"""

NIXOS_USAGE = """
Usage: system nixos <sub-command> [...arguments]

sub-command:

    help:

        Print help message and exit.

    setup:

        Perform setup actions for the system.
        Run only once for a new system.

    switch:

        Switch to new configuration by rebuilding using nixos.

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

    link:

        Relink config files and directories to .config
"""
