#!/bin/sh

set -euo pipefail
set -x

uv tool install debugpy
uv tool install pyright
uv tool install typer
