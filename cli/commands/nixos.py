import re
import socket
from pathlib import Path
import json

import typer

import utils
from config import values as v
from utils.result import Err, Ok, Result

app = typer.Typer(help=v.NIXOS_TYPER_HELP_STR)

### Command Functions ###


def setup_nixos() -> Result[None, str]:
    if not Path("/etc/NIXOS").exists():
        confirm = utils.io.get_confirmation(
            "Detected that this is not an installation environment. Do you still want to run the 'setup' command?"
        )

        if not confirm:
            return Ok(None)

    HOSTNAME = utils.io.get_input("Enter hostname: ")
    USERNAME = utils.io.get_input("Enter username: ")
    ROOT_PATH = Path(utils.io.get_input("Enter root path: "))

    if not ROOT_PATH.is_dir():
        return Err(f"Root path {ROOT_PATH} not found")

    ROOT_CONFIG_DIR = ROOT_PATH / "etc" / "nixos"
    ROOT_HARDWARE_FILE = ROOT_CONFIG_DIR / "hardware-configuration.nix"

    HOST_CONFIG_DIR = v.NIXOS_DIR / HOSTNAME
    HOST_HARDWARE_FILE = HOST_CONFIG_DIR / "hardware.nix"

    utils.io.info(f"Checking if root config exists at {ROOT_CONFIG_DIR}")
    if not ROOT_CONFIG_DIR.is_dir() or not ROOT_HARDWARE_FILE.is_file():
        utils.io.info(f"Making root config at {ROOT_CONFIG_DIR}")
        utils.runner.run(
            f"nixos-generate-config --root {ROOT_PATH}",
            capture=True,
            critical=True,
        )

    utils.io.info(f"Checking if host config exists at {HOST_CONFIG_DIR}")
    if not HOST_CONFIG_DIR.is_dir():
        return Err(
            f"Host config for host {HOSTNAME} does not exist at {HOST_CONFIG_DIR}. Please create it before running the setup"
        )

    utils.io.info("Updating hardware file for host")
    utils.runner.run(
        f"cp -f {ROOT_HARDWARE_FILE} {HOST_HARDWARE_FILE}",
        capture=True,
        critical=True,
    )

    utils.io.info(f"Checking if flake file has {HOSTNAME}")
    try:
        with open(v.NIXOS_FLAKE_FILE, "r") as file:
            flake = file.read()

    except Exception as e:
        return Err(f"Failed to check flake file. Error: {e}")

    check = rf"(nixosConfigurations\.{HOSTNAME}\s*=\s*nixpkgs\.lib\.nixosSystem\s*)"
    if not re.search(check, flake, re.DOTALL):
        return Err(f"Flake file does not have hostname {HOSTNAME}")

    utils.io.info("Adding new config to git")
    utils.runner.run(f"git add {v.NIXOS_DIR}", capture=True, critical=True)

    utils.io.info("Installing system")
    utils.runner.run(
        f"nixos-install --flake {v.SYSTEM_FLAKE_DIR}#{HOSTNAME}",
        capture=False,
        critical=True,
    )

    if USERNAME != "":
        utils.io.info(f"Setting password for {USERNAME}")
        utils.runner.run(
            f"nixos-enter --root {ROOT_PATH} -c 'passwd {USERNAME}'",
            capture=False,
            critical=True,
        )

    return Ok(None)


def switch_nixos() -> Result[None, str]:
    HOSTNAME = socket.gethostname()
    if not HOSTNAME:
        return Err("Failed to get hostname")

    utils.io.info("Switching nixos config")
    utils.runner.run(
        f"sudo nixos-rebuild switch --flake {v.SYSTEM_FLAKE_DIR}#{HOSTNAME}",
        critical=True,
        capture=False,
    )

    return Ok(None)


def list_generations() -> Result[None, str]:
    utils.runner.run(
        "sudo nixos-rebuild list-generations",
        critical=True,
        capture=False,
    )

    return Ok(None)


def search_pkgs(search_param: str, use_nvim) -> Result[None, str]:
    search_results_json = json.loads(
        utils.runner.run(
            f"nix search nixpkgs {search_param} --json", capture=True, critical=True
        ).unwrap()
    )

    search_results = [{"title": k} | v for k, v in search_results_json.items()]

    search_results.sort(
        key=lambda x: (
            search_param not in x["title"].lower(),
            not x.get("description"),
            len(x["title"].split(".")[-1]),
        )
    )

    output = []

    for result in search_results:
        title = result["title"]
        description = result["description"]
        version = result["version"]

        if not use_nvim:
            highlighted_title = utils.io.highlight_matches(title, search_param)
            title = f"{utils.io.BOLD_WHITE}{highlighted_title}{utils.io.RESET}"
            description = utils.io.highlight_matches(
                result["description"], search_param
            )

        output.append(f"{title} ({version})\n\t{description}")

    output_str = "\n\n".join(output)

    import subprocess

    if use_nvim:
        subprocess.run(
            ["nvim", "-"],
            input=output_str,
            text=True,
        )
    else:
        subprocess.run(
            ["less", "-RFX"],
            input=output_str,
            text=True,
        )

    return Ok(None)


### Sub Commands ###


@app.command(help=v.NIXOS_TYPER_HELP["setup"])
def setup():
    result = setup_nixos()
    match result:
        case Err(e):
            utils.io.error(e)
            exit(1)

    exit(0)


@app.command(help=v.NIXOS_TYPER_HELP["switch"])
def switch():
    result = switch_nixos()
    match result:
        case Err(e):
            utils.io.error(e)
            exit(1)

    exit(0)


@app.command(help=v.NIXOS_TYPER_HELP["generation"])
def generation():
    result = list_generations()
    match result:
        case Err(e):
            utils.io.error(e)
            exit(1)

    exit(0)


@app.command("search-pkgs", help=v.NIXOS_TYPER_HELP["search-pkgs"])
def search(search_param: str, nvim: bool = False):
    result = search_pkgs(search_param, use_nvim=nvim)
    match result:
        case Err(e):
            utils.io.error(e)
            exit(1)

    exit(0)
