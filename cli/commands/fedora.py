import typer

from config import values as v
from utils.result import Err, Ok, Result
import utils

app = typer.Typer(help=v.FEDORA_TYPER_HELP_STR)

### Command Functions ###


def setup_fedora() -> Result[None, str]:
    utils.io.info("Updating dnf.conf")
    DNF_CONF = v.FEDORA_DIR / "dnf.conf"
    utils.runner.run(
        f"sudo tee /etc/dnf/dnf.conf < {DNF_CONF} ", critical=True, capture=True
    )

    utils.io.info("Installing base packages")
    packages = set()
    repos = set()

    with open(v.FEDORA_PACKAGES_LIST, "r") as f:
        lines = f.readlines()

    for line in lines:
        line = line.strip()
        if line.startswith("#"):
            continue

        words = line.split(" ")
        if len(words) == 2:
            repos.add(words[0])
            packages.add(words[1])
        elif len(words) == 1:
            packages.add(words[0])
        else:
            return Err(f"Invalid packages.txt: {line}")

    for repo in repos:
        utils.runner.run(f"sudo dnf copr enable {repo}", critical=True, capture=False)

    package_str = " ".join(list(packages))
    utils.runner.run(f"sudo dnf install {package_str}", critical=True, capture=False)

    utils.io.info("Installing flatpaks")
    paks = set()

    utils.runner.run(
        "flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo",
        critical=True,
        capture=False,
    )

    with open(v.FEDORA_FLATPAK_LIST, "r") as f:
        lines = f.readlines()

    for line in lines:
        line = line.strip()
        if line.startswith("#"):
            continue

        paks.add(line)

    for pak in paks:
        utils.runner.run(f"flatpak install flathub {pak}", critical=True, capture=False)

    utils.io.info("Running all install scripts")
    for file in v.FEDORA_INSTALL_DIR.iterdir():
        if file.is_file() and file.suffix == ".sh":
            utils.runner.run(f"{file}", critical=True, capture=False)

    return Ok(None)


## Sub Commands ###


@app.command(help=v.FEDORA_TYPER_HELP["setup"])
def setup():
    result = setup_fedora()
    match result:
        case Err(e):
            utils.io.error(e)
            exit(1)

    exit(0)
