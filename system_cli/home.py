import os
from pathlib import Path
import getpass
import values as v
import utils as u


def setup_fonts():
    print("Setting up fonts...")
    system_fonts_dir = Path("~/.local/share").expanduser()
    fonts_dir = Path("~/Fonts").expanduser()

    system_fonts_dir.mkdir(parents=True, exist_ok=True)
    if fonts_dir.is_dir():
        print("Fonts dir already exists. Skipping...")
    else:
        print("Pulling down fonts repo...")
        u.run_sys(f"git clone git@github.com:nishantHolla/fonts.git {fonts_dir}")

    if system_fonts_dir.exists():
        print(f"{system_fonts_dir} already exists. Skipping linking...")
    else:
        print("Linking fonts dir...")
        u.run_sys(f"ln -s {fonts_dir} {system_fonts_dir}")


def setup_icons():
    print("Setting up icons...")
    system_icons_dir = Path("~/.local/share/icons/GI").expanduser()
    icons_dir = Path("~/Icons").expanduser()

    if icons_dir.is_dir():
        print("Icons dir already exists. Skipping...")
    else:
        print("Pulling down icons repo...")
        u.run_sys(f"git clone git@github.com:nishantHolla/icons.git {icons_dir}")

    if system_icons_dir.exists():
        print(f"{system_icons_dir} already exists. Skipping linking...")
    else:
        print("Linking icons dir...")
        u.run_sys(f"ln -s {icons_dir} {system_icons_dir}")


def setup_wallpapers():
    print("Setting up wallpapers...")
    wallpapers_dir = Path("~/Wallpapers").expanduser()

    if wallpapers_dir.is_dir():
        print("Wallpapers dir already exists. Skipping...")
    else:
        print("Pulling down wallpapers repo...")
        u.run_sys(
            f"git clone git@github.com:nishantHolla/wallpapers.git {wallpapers_dir}"
        )


def setup_awesome():
    print("Setting up awesome...")
    Path("~/.local/share/awesome/notification_history.txt").expanduser().touch(
        parents=True, exist_ok=True
    )
    Path("~/.local/share/awesome/notes.txt").expanduser().touch(
        parents=True, exist_ok=True
    )


def setup_links():
    print("Setting up links...")

    source_dir = v.SYSTEM_DIR / "config"
    dest_dir = Path("~/.config").expanduser()

    for item in source_dir.iterdir():
        if item.is_dir():
            link_path = dest_dir / item.name
            try:
                link_path.symlink_to(item.resolve())
                print(f"Linking {link_path} to {item.resolve()}")

            except FileExistsError:
                print(f"{link_path} already exists. Skipping...")


def setup():
    SSH_DIR = Path("~/.ssh").expanduser()
    TEMP_DIR = Path("~/github").expanduser()

    print("Setting up home-manager...")
    USER = os.getenv("USER")
    u.run_sys(
        f"nix run home-manager/master -- switch --flake {v.HOME_MANAGER_DIR}#{USER}"
    )

    print("Preparing to pull down ssh key...")
    username = input("Enter mega username: ")
    password = getpass.getpass("Enter mega password:")
    u.run_sys(f"rclone config create mega mega user {username} pass {password}")
    SSH_DIR.mkdir(parents=True, exist_ok=True)

    print("Pulling down ssh key..")
    u.run_sys(f"rclone copy mega:/secrets/github {TEMP_DIR}")
    u.run_sys(f"cp {TEMP_DIR}/* {SSH_DIR}")
    u.run_sys(f"rmdir {TEMP_DIR}")

    print("Decrypting ssh key..")
    u.run_sys("gpg -d ~/.ssh/github_rsa.gpg > ~/.ssh/github_rsa")
    u.run_sys("chmod 600 ~/.ssh/github_rsa")

    print("Adding ssh key")
    u.run_sys("ssh-add ~/.ssh/github_rsa")

    print("Chaning origin of system...")
    u.run_sys(
        f"git -C {v.SYSTEM_DIR} remote set-url origin git@github.com:nishantHolla/system.config.git"
    )

    setup_fonts()
    setup_icons()
    setup_wallpapers()
    setup_awesome()
    setup_links()


def run(args):
    if len(args) == 0:
        print(v.HOME_USAGE)
        return 1

    sub_command = args.pop(0)

    if sub_command == "help":
        print(v.HOME_USAGE)

    elif sub_command == "setup":
        exit_code = setup()
        if exit_code:
            return exit_code

    else:
        print(
            f'Unknown sub-command "{sub_command}.\nRun "system home help" for list of sub-commands'
        )
        return 1

    return 0
