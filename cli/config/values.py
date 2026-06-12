from pathlib import Path

## Paths

SYSTEM_CLI_DIR = Path(__file__).parent.parent
SYSTEM_DIR = SYSTEM_CLI_DIR.parent
SYSTEM_CONFIG_DIR = SYSTEM_DIR / "config"

NIXOS_DIR = SYSTEM_DIR / "nixos"
NIXOS_TEMPLATE_DIR = NIXOS_DIR / "template"
NIXOS_FLAKE_FILE = NIXOS_DIR / "flake.nix"

## Help

SYSTEM_TYPER_HELP_STR = "CLI for System"

NIXOS_TYPER_HELP_STR = "Control system-level configuration"
NIXOS_TYPER_HELP = {
    "setup": "Perform setup actions for the system",
    "switch": "Switch to new configuration by rebuilding using nixos",
}
