from log import Log
import values as v
import utils as u

import os
import random
from pathlib import Path


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


def setup():
    SSH_DIR = Path("~/.ssh").expanduser()
    SSH_FILE = SSH_DIR / "github_rsa"
    TEMP_DIR = Path(f"~/github.{random.randint(0, 1000)}").expanduser()

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

    Log.info("setup", "Pulling down ssh key")
    remotes, ec, err = u.run("setup", "rclone listremotes", capture=True)
    if ec:
        Log.error("setup", f"Failed to list remotes. Error: {err}")
        return 2

    if "mega:" not in remotes:
        Log.info("Preparing to connect to mega drive")
        username = Log.input("setup", "Enter mega username: ")
        password = Log.input("setup", "Enter mega password: ", passwd=True)

        ec = u.run(
            "setup",
            f"rclone config create mega mega user {username} pass {password}",
            capture=False,
        )
        if ec:
            Log.error("setup", "Failed to connect to mega drive")
            return 2

    if not SSH_FILE.is_file():
        SSH_DIR.mkdir(parents=True, exist_ok=True)

        ec = u.run(
            "setup", f"rclone copy mega:/secrets/github {TEMP_DIR}", capture=False
        )
        if ec:
            Log.error("setup", "Failed to pull down ssh key")
            return 2

        ec = u.run("setup", f"mv {TEMP_DIR}/* {SSH_DIR}", capture=False)
        if ec:
            Log.error("setup", "Failed to pull down ssh key")
            return 2

        ec = u.run("setup", f"rmdir {TEMP_DIR}", capture=False)
        if ec:
            Log.error("setup", "Failed to pull down ssh key")
            return 2

        Log.info("setup", "Decrypting ssh key")
        ec = u.run(
            "setup",
            "gpg -d ~/.ssh/github_rsa.gpg > ~/.ssh/github_rsa && chmod 600 ~/.ssh/github_rsa",
            capture=False,
        )
        if ec:
            Log.error("setup", "Failed to decrypt ssh key")
            return 2

        Log.info("setup", "Adding ssh key")
        ec = u.run("setup", "ssh-add ~/.ssh/github_rsa", capture=False)
        if ec:
            Log.error("setup", "Failed to add ssh key")
            return 2

    Log.info("Changing origin of the system repo")
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
        return ec

    ec = setup_icons()
    if ec:
        return ec

    ec = setup_wallpapers()
    if ec:
        return ec

    ec = setup_awesome()
    if ec:
        return ec

    ec = setup_links()
    if ec:
        return ec

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

    else:
        Log.error(
            "home",
            f"Unknown sub-command {sub_command}\nRun 'system home help' for list of sub-commands",
        )
        return 1

    return 0
