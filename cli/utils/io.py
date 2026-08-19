import logging
import re
from getpass import getpass

logging.basicConfig(
    level=logging.INFO,
    format="[%(levelname)s] %(message)s",
)

_logger = logging.getLogger("system")

BOLD_WHITE = "\033[1;37m"
BOLD_GREEN = "\033[1;32m"
RESET = "\033[0m"


def highlight_matches(text: str, term: str) -> str:
    pattern = re.compile(re.escape(term), re.IGNORECASE)

    return pattern.sub(
        lambda match: f"{BOLD_GREEN}{match.group()}{RESET}",
        text,
    )


def get_confirmation(prompt: str) -> bool:
    while True:
        confirmation = get_input(f"{prompt} [y/n]").lower()

        if confirmation == "y":
            return True

        if confirmation == "n":
            return False


def get_input(prompt: str) -> str:
    return input(f"[INPT] {prompt}")


def get_password(prompt: str) -> str:
    return getpass(f"[INPT] {prompt}")


def debug(msg: str) -> None:
    _logger.debug(msg)


def info(msg: str) -> None:
    _logger.info(msg)


def warning(msg: str) -> None:
    _logger.warning(msg)


def error(msg: str) -> None:
    _logger.error(msg)
