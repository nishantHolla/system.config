import os
import shlex
from pathlib import Path
import json

import utils
from config import usage as u
from config import values as v
from utils.result import Result


def setup_fonts() -> Result:
    utils.io.info("setup", "Setting up fonts")

    v.SYSTEM_FONTS_DIR.parent.mkdir(parents=True, exist_ok=True)
    if not v.HOME_FONTS_DIR.exists():
        utils.io.info("setup", "Pulling down fonts repo")
        utils.runner.run(
            "setup",
            f"git clone git@github.com:nishantHolla/fonts.git {v.HOME_FONTS_DIR}",
            capture=True,
            critical=True,
        )

    if not v.SYSTEM_FONTS_DIR.exists():
        utils.io.info("setup", "Linking fonts dir")
        v.SYSTEM_FONTS_DIR.symlink_to(v.HOME_FONTS_DIR)

    return Result(0, "Ok")


def setup_icons() -> Result:
    utils.io.info("setup", "Setting up icons")

    v.SYSTEM_ICONS_DIR.parent.mkdir(parents=True, exist_ok=True)
    if not v.HOME_ICONS_DIR.exists():
        utils.io.info("setup", "Pulling down icons repo")
        utils.runner.run(
            "setup",
            f"git clone git@github.com:nishantHolla/icons.git {v.HOME_ICONS_DIR}",
            capture=True,
            critical=True,
        )

    if not v.SYSTEM_ICONS_DIR.exists():
        utils.io.info("setup", "Linking icons dir")
        v.SYSTEM_ICONS_DIR.symlink_to(v.HOME_ICONS_DIR)

    return Result(0, "Ok")


def setup_wallpapers() -> Result:
    utils.io.info("setup", "Setting up wallpapers")

    if not v.HOME_WALLPAPERS_DIR.exists():
        utils.io.info("setup", "Pulling down wallpapers repo")
        utils.runner.run(
            "setup",
            f"git clone git@github.com:nishantHolla/wallpapers.git {v.HOME_WALLPAPERS_DIR}",
            capture=True,
            critical=True,
        )

    return Result(0, "Ok")


def setup_awesome() -> Result:
    utils.io.info("setup", "Setting up awesome")

    v.AWESOME_DIR.mkdir(parents=True, exist_ok=True)
    open(v.AWESOME_DIR / "notification_history.txt", "a").close()
    open(v.AWESOME_DIR / "notes.txt", "a").close()

    return Result(0, "Ok")


def setup_links() -> Result:
    utils.io.info("setup", "Setting up links")

    DEST_DIR = Path("~/.config").expanduser()
    for item in v.SYSTEM_CONFIG_DIR.iterdir():
        link_path = DEST_DIR / item.name
        if link_path.exists():
            utils.io.info("setup", f"{link_path} exists. Skipping")
        else:
            p = item.resolve()
            link_path.symlink_to(p)
            utils.io.info("setup", f"Linking {link_path} to {p}")

    # Temporary solution: Git config is not being identified at $XDG_CONFIG_HOME/git/config
    GIT_SRC_CONFIG = Path("~/.config/git/config").expanduser()
    GIT_DEST_CONFIG = Path("~/.gitconfig").expanduser()
    GIT_SRC_CONFIG.symlink_to(GIT_DEST_CONFIG)

    return Result(0, "Ok")


def setup() -> Result:
    SSH_DIR = Path("~/.ssh").expanduser()
    SSH_FILE = SSH_DIR / "github_rsa"
    SSH_PUB_FILE = SSH_DIR / "github_rsa.pub"
    GPG_FILE = Path("~/gpg").expanduser()

    USER = os.getenv("USER")
    if not USER:
        return Result(1, "Failed to get USER env")

    HOME_CONFIG_DIR = v.HOME_MANAGER_DIR / USER
    utils.io.info("setup", f"Checking if home config exists at {HOME_CONFIG_DIR}")
    if not HOME_CONFIG_DIR.is_dir():
        return Result(2, f"Could not find home config dir for {USER}")

    utils.io.info("setup", "Setting up home-manager")
    utils.runner.run(
        "setup",
        f"nix run home-manager/master -- switch --flake {v.HOME_MANAGER_DIR}#{USER}",
        capture=False,
        critical=True,
    )

    utils.io.info("setup", "Configuring bitwarden")
    utils.runner.run(
        "setup",
        "bw config server https://vault.bitwarden.eu",
        capture=True,
        critical=True,
    )

    BW_USERNAME = utils.io.get_input("setup", "Bitwarden email: ")
    BW_PASSWORD = utils.io.get_password("setup", "Bitwarden password: ")

    utils.io.info("setup", "Logging in to bitwarden")
    utils.runner.run(
        "setup",
        f"bw login {shlex.quote(BW_USERNAME)} {shlex.quote(BW_PASSWORD)}",
        capture=False,
        critical=True,
    )

    session, _, _ = utils.runner.run(
        "setup",
        f"bw unlock --raw {shlex.quote(BW_PASSWORD)}",
        capture=True,
        critical=True,
    )

    utils.runner.run(
        "setup", f'bw sync --session "{session}"', capture=True, critical=True
    )

    utils.io.info("setup", "Pulling down ssh key from bitwarden")
    note, _, _ = utils.runner.run(
        "setup",
        f'bw get item --session {session} "GithubSSH"',
        capture=True,
        critical=True,
    )

    j = json.loads(note)
    SSH_DIR.mkdir(parents=True, exist_ok=True)

    with open(SSH_FILE, "w") as f:
        f.write(j["notes"])

    with open(SSH_PUB_FILE, "w") as f:
        f.write(j["fields"][0]["value"])

    utils.runner.run("setup", f"sudo chmod 600 {SSH_FILE}", capture=True, critical=True)
    utils.runner.run("setup", f"ssh-add {SSH_FILE}", capture=True, critical=True)

    utils.io.info("setup", "Pulling down gpg key from bitwarden")
    note, _, _ = utils.runner.run(
        "setup",
        f'bw get item --session {session} "GithubGPG-Public"',
        capture=True,
        critical=True,
    )
    j = json.loads(note)

    with open(GPG_FILE, "w") as f:
        f.write(j["notes"])

    utils.runner.run("setup", f"gpg --import {GPG_FILE}", capture=True, critical=True)

    note, _, _ = utils.runner.run(
        "setup",
        f'bw get item --session {session} "GithubGPG-Private"',
        capture=True,
        critical=True,
    )
    j = json.loads(note)

    with open(GPG_FILE, "w") as f:
        f.write(j["notes"])

    utils.runner.run("setup", f"gpg --import {GPG_FILE}", capture=True, critical=True)
    os.remove(GPG_FILE)

    utils.io.info("setup", "Changing origin of the system repo")
    utils.runner.run(
        "setup", f"git restore --staged {v.SYSTEM_DIR}", capture=True, critical=True
    )
    utils.runner.run(
        "setup",
        f"git -C {v.SYSTEM_DIR} remote set-url origin git@github.com:nishantHolla/system.config.git",
        capture=True,
        critical=True,
    )

    ec = setup_fonts()
    if ec.code != 0:
        return Result(4, ec.message)

    ec = setup_icons()
    if ec.code != 0:
        return Result(5, ec.message)

    ec = setup_wallpapers()
    if ec.code != 0:
        return Result(6, ec.message)

    ec = setup_awesome()
    if ec.code != 0:
        return Result(7, ec.message)

    ec = setup_links()
    if ec.code != 0:
        return Result(8, ec.message)

    return Result(0, "Ok")


def link() -> Result:
    ec = setup_links()
    if ec.code != 0:
        return ec

    return Result(0, "Ok")


def switch() -> Result:
    USER = os.getenv("USER")
    if not USER:
        return Result(1, "Failed to get USER env")

    utils.io.info("switch", "Switching home-manager config")
    utils.runner.run(
        "switch",
        f"home-manager switch --flake {v.HOME_MANAGER_DIR}#{USER}",
        capture=False,
        critical=True,
    )

    return Result(0, "ok")


def run(args):
    if len(args) == 0:
        utils.io.info("home", u.HOME_USAGE)
        return 1

    sub_command = args.pop(0)

    if sub_command == "help":
        utils.io.info("home", u.HOME_USAGE)

        return 0

    elif sub_command == "setup":
        result = setup()

        if result.code != 0:
            utils.io.error("setup", result.message)

        return result.code

    elif sub_command == "switch":
        result = switch()

        if result.code != 0:
            utils.io.error("switch", result.message)

        return result.code

    elif sub_command == "link":
        result = link()

        if result.code != 0:
            utils.io.error("link", result.message)

        return result.code

    else:
        utils.io.error(
            "home",
            f"Unknown sub-command {sub_command}\n"
            "Run 'homelab home help' for list of all sub-commands",
        )
        return 1
