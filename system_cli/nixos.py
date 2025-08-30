from log import Log
import values as v
import utils as u

import re


def setup():
    HOSTNAME = Log.input("nixos", "Enter hostname: ")
    USERNAME = Log.input("nixos", "Enter username: ")
    ROOT_PATH = Log.input("nixos", "Enter root path: ")

    ROOT_CONFIG_DIR = ROOT_PATH / "etc" / "nixos"
    ROOT_HARDWARE_FILE = ROOT_CONFIG_DIR / "hardware-configuration.nix"

    HOST_CONFIG_DIR = v.NIXOS_DIR / HOSTNAME
    HOST_CONFIG_FILE = HOST_CONFIG_DIR / "config.nix"
    HOST_PACKAGE_FILE = HOST_CONFIG_DIR / "package.nix"
    HOST_HARDWARE_FILE = HOST_CONFIG_DIR / "hardware.nix"

    Log.info("setup", f"Checking if root config exists at {ROOT_CONFIG_DIR}")
    if not ROOT_CONFIG_DIR.is_dir() or not ROOT_HARDWARE_FILE.is_file():
        Log.info("setup", f"Making root config at {ROOT_CONFIG_DIR}")

        _, rc, err = u.run(f"nixos-generate-config --root {ROOT_PATH}", capture=True)
        if rc:
            Log.error("setup", f"Failed to make root config. Error: {err}")
            return 2

    Log.info("setup", f"Checking if host config exists at {HOST_CONFIG_DIR}")
    if (
        not HOST_CONFIG_DIR.is_dir()
        or not HOST_CONFIG_FILE.is_file()
        or not HOST_PACKAGE_FILE.is_file()
    ):
        Log.info("setup", f"Making host config at {HOST_CONFIG_DIR}")

        _, rc, err = u.run(
            f"cp -r {v.NIXOS_TEMPLATE_DIR} {HOST_CONFIG_DIR}", capture=True
        )
        if rc:
            Log.error("setup", f"Failed to make host config. Error: {err}")
            return 2

    Log.info("setup", "Updating hardware file for host")
    _, rc, err = u.run(f"cp -f {ROOT_HARDWARE_FILE} {HOST_HARDWARE_FILE}", capture=True)
    if rc:
        Log.error("setup", f"Failed to update hardware file. Error: {err}")
        return 2

    Log.info("setup", "Updating config file for host")
    rc, err = u.find_and_replace(HOST_CONFIG_FILE, "$TEMPLATE_HOSTNAME", HOSTNAME)
    if rc:
        Log.error("setup", f"Failed to update config file. Error: {err}")
        return 2

    Log.info("setup", f"Checking if flake file has {HOSTNAME}")
    try:
        with open(v.NIXOS_FLAKE_FILE, "r") as file:
            flake = file.read()

    except Exception as e:
        Log.error("setup", f"Failed to check flake file. Error: {e}")
        return 2

    check = rf"(nixosConfigurations\.{HOSTNAME}\s*=\s*nixpkgs\.lib\.nixosSystem\s*)"
    if not re.search(check, flake, re.DOTALL):
        Log.info("setup", "Updating flake file")

        pattern = r"(nixosConfigurations\.template\s*=\s*nixpkgs\.lib\.nixosSystem\s*\{.*?\};)"
        match = re.search(pattern, flake, re.DOTALL)

        if match:
            extracted_block = match.group(1)
            block = extracted_block.replace("template", HOSTNAME)

        else:
            Log.error("setup", "Failed to find template block")
            return 2

        flake = flake[: match.end()] + "\n\n    " + block + flake[match.end() :]
        try:
            with open(v.NIXOS_FLAKE_FILE, "w") as file:
                file.write(flake)
        except Exception as e:
            Log.error("setup", f"Failed to write flake file. Error: {e}")
            return 2

    Log.info("setup", "Adding new config to git")
    _, rc, err = u.run(f"git add {v.NIXOS_DIR}", capture=True)
    if rc:
        Log.error("setup", f"Failed to add config to git. Error: {err}")
        return 2

    Log.info("setup", "Installing system")
    rc = u.run(f"nixos-install --flake {v.NIXOS_DIR}#{HOSTNAME}")
    if rc:
        Log.error("setup", "Failed to install system")
        return 2

    if USERNAME != "":
        Log.info(f"Setting password for {USERNAME}")
        u.run(f"nixos-enter --root {ROOT_PATH} -c 'passwd {USERNAME}'")

    return 0


def run(args):
    if len(args) == 0:
        Log.info("nixos", v.NIXOS_USAGE, new_line=True)
        return 1

    sub_command = args.pop(0)

    if sub_command == "help":
        Log.info("nixos", v.NIXOS_USAGE, new_line=True)

    elif sub_command == "setup":
        ec = setup()
        if ec:
            return ec

    else:
        Log.error(
            "nixos",
            f"Unknown sub-command {sub_command}\nRun 'system nixos help' for list of sub-commands",
        )
        return 1

    return 0
