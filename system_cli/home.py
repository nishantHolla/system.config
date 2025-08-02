import os
from pathlib import Path
import getpass
import values as v
import utils as u


def setup_fonts():
    print("Setting up fonts...")
    system_fonts_dir = Path("~/.local/share/fonts").expanduser()
    fonts_dir = Path("~/Fonts").expanduser()

    system_fonts_dir.parent.mkdir(parents=True, exist_ok=True)
    if fonts_dir.is_dir():
        print("Fonts dir already exists. Skipping...")
    else:
        print("Pulling down fonts repo...")
        u.run_sys(f"git clone git@github.com:nishantHolla/fonts.git {fonts_dir}")

    if system_fonts_dir.exists():
        print(f"{system_fonts_dir} already exists. Skipping linking...")
    else:
        print("Linking fonts dir...")
        system_fonts_dir.symlink_to(fonts_dir)


def setup_icons():
    print("Setting up icons...")
    system_icons_dir = Path("~/.local/share/icons/GI").expanduser()
    icons_dir = Path("~/Icons/GI").expanduser()

    system_icons_dir.parent.mkdir(parents=True, exist_ok=True)
    if icons_dir.is_dir():
        print("Icons dir already exists. Skipping...")
    else:
        print("Pulling down icons repo...")
        u.run_sys(f"git clone git@github.com:nishantHolla/icons.git {icons_dir}")

    if system_icons_dir.exists():
        print(f"{system_icons_dir} already exists. Skipping linking...")
    else:
        print("Linking icons dir...")
        system_icons_dir.symlink_to(icons_dir)


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
    AWESOME_DIR = Path("~/.local/share/awesome").expanduser()
    AWESOME_DIR.mkdir(parents=True, exist_ok=True)
    open(AWESOME_DIR / "notification_history.txt", "a").close()
    open(AWESOME_DIR / "notes.txt", "a").close()


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

    remotes, ec, err_msg = u.run("rclone listremotes")
    if ec:
        print("Failed to list remotes\n.Error: {err_msg}")
        return 2

    if "mega:" not in remotes:
        print("Preparing to pull down ssh key...")
        username = input("Enter mega username: ")
        password = getpass.getpass("Enter mega password:")
        u.run_sys(f"rclone config create mega mega user {username} pass {password}")

    if not Path("~/.ssh/github_rsa").expanduser().exists():
        SSH_DIR.mkdir(parents=True, exist_ok=True)

        print("Pulling down ssh key..")
        u.run_sys(f"rclone copy mega:/secrets/github {TEMP_DIR}")
        u.run_sys(f"mv {TEMP_DIR}/* {SSH_DIR}")
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
