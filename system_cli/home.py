from log import Log
import values as v
import utils as u

import os
import shlex
from pathlib import Path
import json


def setup_fonts():
    Log.info("setup", "Setting up fonts")

    v.SYSTEM_FONTS_DIR.parent.mkdir(parents=True, exist_ok=True)
    if not v.HOME_FONTS_DIR.exists():
        Log.info("setup", "Pulling down fonts repo")
        ec = u.run(
            "setup",
            f"git clone git@github.com:nishantHolla/fonts.git {v.HOME_FONTS_DIR}",
            capture=False,
        )
        if ec:
            return ec

    if not v.SYSTEM_FONTS_DIR.exists():
        Log.info("setup", "Linking fonts dir")
        v.SYSTEM_FONTS_DIR.symlink_to(v.HOME_FONTS_DIR)

    return 0


def setup_icons():
    Log.info("setup", "Setting up icons")

    v.SYSTEM_ICONS_DIR.parent.mkdir(parents=True, exist_ok=True)
    if not v.HOME_ICONS_DIR.exists():
        Log.info("setup", "Pulling down fonts repo")
        ec = u.run(
            "setup",
            f"git clone git@github.com:nishantHolla/icons.git {v.HOME_ICONS_DIR}",
            capture=False,
        )
        if ec:
            return ec

    if not v.SYSTEM_ICONS_DIR.exists():
        Log.info("setup", "Linking icons dir")
        v.SYSTEM_ICONS_DIR.symlink_to(v.HOME_ICONS_DIR)

    return 0


def setup_wallpapers():
    Log.info("setup", "Setting up wallpapers")

    if not v.HOME_WALLPAPERS_DIR.exists():
        Log.info("setup", "Pulling down wallpapers repo")
        ec = u.run(
            "setup",
            f"git clone git@github.com:nishantHolla/wallpapers.git {v.HOME_WALLPAPERS_DIR}",
            capture=False,
        )
        if ec:
            return ec

    return 0


def setup_awesome():
    Log.info("setup", "Setting up awesome")

    v.AWESOME_DIR.mkdir(parents=True, exist_ok=True)
    open(v.AWESOME_DIR / "notification_history.txt", "a").close()
    open(v.AWESOME_DIR / "notes.txt", "a").close()

    return 0


def setup_links():
    Log.info("setup", "Setting up links")

    DEST_DIR = Path("~/.config").expanduser()
    for item in v.SYSTEM_CONFIG_DIR.iterdir():
        link_path = DEST_DIR / item.name
        if link_path.exists():
            Log.info("setup", f"{link_path} exists. Skipping")
        else:
            p = item.resolve()
            link_path.symlink_to(p)
            Log.info("setup", f"Linking {link_path} to {p}")

    return 0


def setup():
    SSH_DIR = Path("~/.ssh").expanduser()
    SSH_FILE = SSH_DIR / "github_rsa"
    SSH_PUB_FILE = SSH_DIR / "github_rsa.pub"
    GPG_FILE = Path("~/gpg").expanduser()

    USER = os.getenv("USER")
    if not USER:
        Log.error("setup", "Falied to get USER env")
        return 2

    HOME_CONFIG_DIR = v.HOME_MANAGER_DIR / USER
    Log.info("setup", f"Checking if home config exists at {HOME_CONFIG_DIR}")
    if not HOME_CONFIG_DIR.is_dir():
        Log.error("setup", f"Could not find home config dir for {USER}")
        return 2

    Log.info("setup", "Setting up home-manager")
    ec = u.run(
        "setup",
        f"nix run home-manager/master -- switch --flake {v.HOME_MANAGER_DIR}#{USER}",
        capture=False,
    )
    if ec:
        Log.error("setup", "Failed to setup home-manager")
        return 2

    Log.info("setup", "Configuring bitwarden")
    ec = u.run("setup", "bw config server https://vault.bitwarden.eu", capture=False)
    if ec:
        Log.error("setup", "Failed to change bitwarden server to eu")
        return 2

    BW_USERNAME = Log.input("setup", "Enter bitwarden username: ")
    BW_PASSWORD = Log.input("setup", "Enter bitwarden password: ", passwd=True)

    Log.info("setup", "Logging in to bitwarden")
    ec = u.run(
        "setup",
        f"bw login {shlex.quote(BW_USERNAME)} {shlex.quote(BW_PASSWORD)}",
        capture=False,
    )
    if ec:
        Log.error("setup", "Failed to login to bitwarden")
        return 2

    session, ec, err = u.run("setup", "bw unlock --raw", capture=True)
    if ec:
        Log.error("setup", f"Failed to unlock session: {err}")
        return 2

    ec = u.run("setup", "bw sync", capture=False)
    if ec:
        Log.error("setup", "Failed to sync bitwarden")
        return 2

    Log.info("setup", "Pulling down ssh key from bitwarden")
    note, ec, err = u.run(
        "setup", f'bw get item "GithubSSH" --session {session}', capture=True
    )
    if ec:
        Log.error("setup", f"Failed to get note: {err}")
        return 2

    j = json.loads(note)

    SSH_DIR.mkdir(parents=True, exist_ok=True)
    with open(SSH_FILE, "w") as f:
        f.write(j["notes"])

    with open(SSH_PUB_FILE, "w") as f:
        f.write(j["fields"][0]["value"])

    ec = u.run("setup", f"sudo chmod 600 {SSH_FILE}", capture=False)
    if ec:
        Log.error("setup", "Failed to change permission of ssh file")
        return 2

    ec = u.run("setup", f"ssh-add {SSH_FILE}", capture=False)
    if ec:
        Log.error("setup", "Failed to add ssh key")
        return 2

    Log.info("setup", "Pulling down gpg key from bitwarden")
    note, ec, err = u.run(
        "setup", f'bw get item "GithubGPG-Public" --session {session}', capture=True
    )
    if ec:
        Log.error("setup", f"Failed to get note: {err}")
        return 2

    j = json.loads(note)

    with open(GPG_FILE, "w") as f:
        f.write(j["notes"])

    ec = u.run("setup", f"gpg --import {GPG_FILE}")
    if ec:
        Log.error("setup", "Failed to import gpg public key")
        return 2

    note, ec, err = u.run(
        "setup", f'bw get item "GithubGPG-Private" --session {session}', capture=True
    )
    if ec:
        Log.error("setup", f"Failed to get note: {err}")

    j = json.loads(note)

    with open(GPG_FILE, "w") as f:
        f.write(j["notes"])

    ec = u.run("setup", f"gpg --import {GPG_FILE}")
    if ec:
        Log.error("setup", "Failed to import gpg private key")

    Log.info("setup", "Changing origin of the system repo")
    ec = u.run(
        "setup",
        f"git -C {v.SYSTEM_DIR} remote set-url origin git@github.com:nishantHolla/system.config.git",
        capture=False,
    )
    if ec:
        Log.error("setup", "Failed to change origin")
        return 2

    ec = setup_fonts()
    if ec:
        Log.error("setup", "Font setup failed")
        return ec

    ec = setup_icons()
    if ec:
        Log.error("setup", "Icon setup failed")
        return ec

    ec = setup_wallpapers()
    if ec:
        Log.error("setup", "Wallpaper setup failed")
        return ec

    ec = setup_awesome()
    if ec:
        Log.error("setup", "Awesome setup failed")
        return ec

    ec = setup_links()
    if ec:
        Log.error("setup", "Linking failed")
        return ec

    return 0


def switch():
    USER = os.getenv("USER")
    if not USER:
        Log.error("switch", "Falied to get USER env")
        return 2

    Log.info("switch", "Switching home-manager config")
    ec = u.run(
        "switch",
        f"home-manager switch --flake {v.HOME_MANAGER_DIR}#{USER}",
        capture=False,
    )
    if ec:
        Log.error("switch", "Failed to switch home-manager config")
        return 2

    return 0


def run(args):
    if len(args) == 0:
        Log.info("home", v.HOME_USAGE, new_line=True)
        return 1

    sub_command = args.pop(0)

    if sub_command == "help":
        Log.info("home", v.HOME_USAGE, new_line=True)

    elif sub_command == "setup":
        ec = setup()
        if ec:
            return ec

    elif sub_command == "switch":
        ec = switch()
        if ec:
            return ec

    else:
        Log.error(
            "home",
            f"Unknown sub-command {sub_command}\nRun 'system home help' for list of sub-commands",
        )
        return 1

    return 0
