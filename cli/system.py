#!/usr/bin/env python

import typer
from config import values as v

app = typer.Typer(help=v.SYSTEM_TYPER_HELP_STR, rich_markup_mode=None)

if __name__ == "__main__":
    app()
