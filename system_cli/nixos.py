import values as v
import utils as u
from pathlib import Path
import re


def setup():
    HOSTNAME = input("Enter hostname: ")
    USERNAME = input("Enter username: ")
    ROOT_PATH = Path(input("Enter root path: "))
    CONFIG_DIR = v.NIXOS_DIR / HOSTNAME

    print("Checking if root config exists...")
    if not (ROOT_PATH / "etc" / "nixos").is_dir():
        print("Making root config...")

        root_flag = f"--root {ROOT_PATH}" if ROOT_PATH != "/" else ""
        _, rc, err = u.run(f"nixos-generate-config {root_flag}")
        if rc:
            print(f"Failed to make root config.\nError: {err}")
            return 2

    print(f"Checking if {HOSTNAME} config exists...")
    if not CONFIG_DIR.is_dir():
        print(f"Preparing config files for {HOSTNAME}...")
        _, rc, err = u.run(f"cp -r {v.NIXOS_TEMPLATE_DIR} {CONFIG_DIR}")
        if rc:
            print(f"Failed to copy template config to {HOSTNAME}.\nError: {err}")
            return 2

        print("Copying hardware.nix...")
        _, rc, err = u.run(
            f"cp {ROOT_PATH / 'etc' / 'nixos' / 'hardware-configuration.nix'} {CONFIG_DIR / 'hardware.nix'}"
        )
        if rc:
            print(f"Failed to generate hardware.nix.\nError: {err}")
            return 2

        print(f"Updating config.nix for {HOSTNAME}")
        u.find_and_replace(CONFIG_DIR / "config.nix", "$TEMPLATE_HOSTNAME", HOSTNAME)

    print(f"Checking if flake file has {HOSTNAME}...")
    with open(v.NIXOS_FLAKE_FILE, "r") as file:
        flake = file.read()

    check = rf"(nixosConfigurations\.{HOSTNAME}\s*=nixpkgs\.lib\.nixosSystem\s*)"
    if not re.search(check, flake, re.DOTALL):
        print("Updating nixos flake file...")
        pattern = r"(nixosConfigurations\.template\s*=\s*nixpkgs\.lib\.nixosSystem\s*\{.*?\};)"
        match = re.search(pattern, flake, re.DOTALL)

        if match:
            extracted_block = match.group(1)
            block = extracted_block.replace("template", HOSTNAME)

        else:
            print("Failed to find template block")
            return 2

        flake = flake[: match.end()] + "\n\n    " + block + flake[match.end() :]
        with open(v.NIXOS_FLAKE_FILE, "w") as file:
            file.write(flake)

    print("Adding new config to git...")
    _, rc, err = u.run(f"git add {v.NIXOS_DIR}")
    if rc:
        print(f"Failed to add nixos dir to git.\nError: {err}")
        return 2

    print("Installing system...")
    u.run_sys(f"nixos-install --flake {v.NIXOS_DIR}#{HOSTNAME}")

    if USERNAME != "":
        print(f"Setting password for {USERNAME}...")
        u.run_sys(f"nixos-enter --root {ROOT_PATH} -c 'passwd {USERNAME}'")

    return 0


def run(args):
    if len(args) == 0:
        print(v.NIXOS_USAGE)
        return 1

    sub_command = args.pop(0)

    if sub_command == "help":
        print(v.NIXOS_USAGE)

    elif sub_command == "setup":
        exit_code = setup()
        if exit_code:
            return exit_code

    else:
        print(
            f'Unknown sub-command "{sub_command}.\nRun "system nixos help" for list of sub-commands.'
        )
        return 1

    return 0
