from config import values as v
import json
import shlex
import os
from pathlib import Path
from utils.result import Result, Err, Ok
import utils
import typer

app = typer.Typer(help=v.HOME_TYPER_HELP_STR)

### Command Functions ###


def _setup_home_manager(flake_file: Path | str, user: str) -> Result[None, str]:
    utils.runner.run(
        f"nix run home-manager/master -- switch --flake {flake_file}#{user}",
        capture=False,
        critical=True,
    )

    return Ok(None)


def _get_bitwarden_session() -> Result[str, str]:
    BW_PASSWORD = utils.io.get_password("Bitwarden password: ")
    session = utils.runner.run(
        f"bw unlock --raw {shlex.quote(BW_PASSWORD)}", capture=True, critical=True
    ).unwrap()  # Safe to unwrap because critical is True

    return Ok(session)


def _setup_bitwarden() -> Result[str, str]:
    utils.runner.run(
        f"bw config server {v.BITWARDEN_SERVER_URL}", capture=True, critical=True
    )

    BW_USERNAME = utils.io.get_input("Bitwarden email: ")
    BW_PASSWORD = utils.io.get_password("Bitwarden password: ")

    utils.io.info("Logging into bitwarden")
    utils.runner.run(
        f"bw login {shlex.quote(BW_USERNAME)} {shlex.quote(BW_PASSWORD)}",
        capture=False,
        critical=True,
    )

    session = utils.runner.run(
        f"bw unlock --raw {shlex.quote(BW_PASSWORD)}", capture=True, critical=True
    ).unwrap()  # Safe to unwrap because critical is True

    utils.runner.run(f'bw sync --session "{session}"', capture=True, critical=True)

    return Ok(session)


def _setup_ssh(
    key_file: Path | str, pub_file: Path | str, session: str
) -> Result[None, str]:
    note = utils.runner.run(
        f'bw get item --session "{session}" "{v.BITWARDEN_SSH_KEY_NOTE_NAME}"',
        capture=True,
        critical=True,
    ).unwrap()  # Safe to unwrap because critical is True

    j = json.loads(note)

    with open(key_file, "w") as f:
        f.write(j["notes"])

    with open(pub_file, "w") as f:
        f.write(j["fields"][0]["value"])

    utils.runner.run(f"sudo chmod 600 {key_file}", capture=True, critical=True)
    utils.runner.run(f"ssh-add {key_file}", capture=True, critical=True)

    return Ok(None)


def _setup_gpg(temp_file: Path | str, session: str) -> Result[None, str]:
    note = utils.runner.run(
        f'bw get item --session "{session}" "{v.BITWARDEN_GPG_PUBLIC_KEY_NOTE_NAME}"',
        capture=True,
        critical=True,
    ).unwrap()  # Safe to unwrap because critical is True

    j = json.loads(note)

    with open(temp_file, "w") as f:
        f.write(j["notes"])

    utils.runner.run(f"gpg --import {temp_file}", capture=True, critical=True)

    note = utils.runner.run(
        f'bw get item --session "{session}" "{v.BITWARDEN_GPG_PRIVATE_KEY_NOTE_NAME}"',
        capture=True,
        critical=True,
    ).unwrap()  # Safe to unwrap because critical is True

    j = json.loads(note)

    with open(temp_file, "w") as f:
        f.write(j["notes"])

    utils.runner.run(f"gpg --import {temp_file}", capture=True, critical=True)
    os.remove(temp_file)

    return Ok(None)


def _setup_fonts() -> Result[None, str]:
    v.SYSTEM_FONTS_DIR.parent.mkdir(parents=True, exist_ok=True)
    if not v.HOME_FONTS_DIR.exists():
        utils.io.info("Pulling down fonts repo")
        utils.runner.run(
            f"git clone {v.FONTS_REPO_URL} {v.HOME_FONTS_DIR}",
            capture=False,
            critical=True,
        )
    else:
        utils.io.warning(f"{v.HOME_ICONS_DIR} already exists. Skipping pull")

    if not v.SYSTEM_FONTS_DIR.exists():
        utils.io.info("Linking fonts dir")
        v.SYSTEM_FONTS_DIR.symlink_to(v.HOME_FONTS_DIR)
    else:
        utils.io.warning(f"{v.SYSTEM_FONTS_DIR} already exists. Skipping linking")

    return Ok(None)


def _setup_icons() -> Result[None, str]:
    v.SYSTEM_ICONS_DIR.parent.mkdir(parents=True, exist_ok=True)
    if not v.HOME_ICONS_DIR.exists():
        utils.io.info("Pulling down icons repo")
        utils.runner.run(
            f"git clone {v.ICONS_REPO_URL} {v.HOME_ICONS_DIR}",
            capture=False,
            critical=True,
        )
    else:
        utils.io.warning(f"{v.HOME_ICONS_DIR} already exists. Skipping pull")

    if not v.SYSTEM_ICONS_DIR.exists():
        utils.io.info("Linking icons dir")
        v.SYSTEM_ICONS_DIR.symlink_to(v.HOME_ICONS_DIR)
    else:
        utils.io.warning(f"{v.SYSTEM_ICONS_DIR} already exists. Skipping linking")

    return Ok(None)


def _setup_wallpapers() -> Result[None, str]:
    if not v.HOME_WALLPAPERS_DIR.exists():
        utils.io.info("Pulling down wallpapers repo")
        utils.runner.run(
            f"git clone {v.WALLPAPERS_REPO_URL} {v.HOME_WALLPAPERS_DIR}",
            capture=False,
            critical=True,
        )
    else:
        utils.io.warning(f"{v.HOME_WALLPAPERS_DIR} already exists. Skipping pull")

    return Ok(None)


def _setup_config() -> Result[None, str]:
    DEST_DIR = Path("~/.config").expanduser()

    for item in v.SYSTEM_CONFIG_DIR.iterdir():
        link_path = DEST_DIR / item.name

        if link_path.exists():
            utils.io.warning(f"{link_path} already exists. Skipping linking")
        else:
            p = item.resolve()
            link_path.symlink_to(p)
            utils.io.info(f"Linking {link_path} to {p}")

    # Temporary solution: Git config is not being identified at $XDG_CONFIG_HOME/git/config
    GIT_SRC_CONFIG = Path("~/.config/git/config").expanduser()
    GIT_DEST_CONFIG = Path("~/.gitconfig").expanduser()

    if not GIT_DEST_CONFIG.exists():
        GIT_DEST_CONFIG.symlink_to(GIT_SRC_CONFIG)

    return Ok(None)


def _setup_awesome() -> Result[None, str]:
    v.AWESOME_DIR.mkdir(parents=True, exist_ok=True)
    open(v.AWESOME_DIR / "notification_history.txt", "a").close()
    open(v.AWESOME_DIR / "notes.txt", "a").close()

    return Ok(None)


def setup_home() -> Result[None, str]:
    SSH_DIR = Path("~/.ssh").expanduser()
    SSH_FILE = SSH_DIR / "github_rsa"
    SSH_PUB_FILE = SSH_DIR / "github_rsa.pub"
    TEMP_GPG_FILE = Path("~/gpg").expanduser()

    USER = os.getenv("USER")
    if not USER:
        return Err("Failed to get USER env")

    HOME_CONFIG_DIR = v.HOME_MANAGER_DIR / USER
    utils.io.info(f"Checking if home config exists at {HOME_CONFIG_DIR}")
    if not HOME_CONFIG_DIR.is_dir():
        return Err(
            f"Could not find home config directory for {USER} at {HOME_CONFIG_DIR}"
        )

    ## Home Manager

    utils.io.info("Checking if home-manager is installed")
    result = utils.runner.run("home-manager --version", critical=False, capture=True)
    match result:
        case Err(_):
            utils.io.info("Setting up home-manager")
            _setup_home_manager(v.HOME_MANAGER_DIR, USER)
        case Ok(_):
            utils.io.info(
                "home-manager is already installed. Skipping installation of home manager"
            )

    ## Bitwarden

    utils.io.info("Checking if bitwarden is setup")
    result = utils.runner.run(
        r'bw status | grep -q "\"status\":\"unauthenticated\""',
        capture=True,
        critical=False,
    )

    match result:
        case Err(_):
            is_unauthenticated = False
        case Ok(_):
            is_unauthenticated = True

    if is_unauthenticated:
        setup_bw = True
    else:
        confirm = utils.io.get_confirmation(
            "Bitwarden is already setup. Do you want to log out?"
        )

        if confirm:
            utils.runner.run("bw logout", capture=True, critical=True)
            setup_bw = True
        else:
            setup_bw = False

    if setup_bw:
        utils.io.info("Setting up bitwarden")
        session = _setup_bitwarden().unwrap()
    else:
        session = _get_bitwarden_session().unwrap()

    ## Github SSH keys

    if SSH_DIR.is_dir():
        confirm = utils.io.get_confirmation(
            f"{SSH_DIR} is already present. Do you want to pull down ssh key?"
        )
        if confirm:
            utils.io.info("Pulling down SSH keys from bitwarden")
            SSH_DIR.mkdir(parents=True, exist_ok=True)
            _setup_ssh(SSH_FILE, SSH_PUB_FILE, session)

    ## Github GPG keys

    confirm = utils.io.get_confirmation("Do you want to pull down gpg key?")
    if confirm:
        utils.io.info("Pulling dow GPG keys from bitwarden")
        _setup_gpg(TEMP_GPG_FILE, session)

    ## Git repo

    utils.io.info("Changing origin of the system repo")
    utils.runner.run(
        f"git restore --staged {v.SYSTEM_DIR}", capture=True, critical=True
    )
    utils.runner.run(
        f"git -C {v.SYSTEM_DIR} remote set-url origin {v.SYSTEM_REPO_URL}",
        capture=True,
        critical=True,
    )

    ## Fonts

    utils.io.info("Setting up fonts")
    result = _setup_fonts()
    match result:
        case Err(e):
            utils.io.error(f"Failed to setup fonts. Error: {e}")

    ## Icons

    utils.io.info("Setting up icons")
    result = _setup_icons()
    match result:
        case Err(e):
            utils.io.error(f"Failed to setup icons. Error: {e}")

    ## Wallpapers

    utils.io.info("Setting up wallpapers")
    result = _setup_wallpapers()
    match result:
        case Err(e):
            utils.io.error(f"Failed to setup wallpapers. Error: {e}")

    ## Awesome

    utils.io.info("Setting up awesome")
    result = _setup_awesome()
    match result:
        case Err(e):
            utils.io.error(f"Failed to setup awesome. Error: {e}")

    ## Config

    utils.io.info("Setting up config")
    result = _setup_config()
    match result:
        case Err(e):
            utils.io.error(f"Failed to setup config. Error: {e}")

    return Ok(None)


def switch_home() -> Result[None, str]:
    USER = os.getenv("USER")
    if not USER:
        return Err("Failed to get USER env")

    utils.io.info("Switching home-manager config")
    utils.runner.run(
        f"home-manager switch --flake {v.HOME_MANAGER_DIR}#{USER}",
        capture=False,
        critical=True,
    )

    return Ok(None)


### Sub Commands ###


@app.command(help=v.HOME_TYPER_HELP["setup"])
def setup():
    result = setup_home()
    match result:
        case Err(e):
            utils.io.error(e)
            exit(1)

    exit(0)


@app.command(help=v.HOME_TYPER_HELP["switch"])
def switch():
    result = switch_home()
    match result:
        case Err(e):
            utils.io.error(e)
            exit(1)

    exit(0)
