#!/usr/bin/env python

import typer
from config import values as v
from commands import nixos
from commands import home

app = typer.Typer(help=v.SYSTEM_TYPER_HELP_STR, rich_markup_mode=None)
app.add_typer(nixos.app, name="nixos")
app.add_typer(home.app, name="home")

if __name__ == "__main__":
    app()
