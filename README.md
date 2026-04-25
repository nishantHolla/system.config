# system.config

Personal NixOS + Home Manager configuration, AwesomeWM setup, helper shell utilities, and a small Python CLI used to bootstrap and manage the system.

> This repository is opinionated and tuned for my environment. It can still be a strong template if you want a flake-based Linux setup with modular config files and scriptable workflows.

## What this repo contains

- **NixOS host definitions** under `nixos/` (host configs are generated from `nixos/template/`).
- **Home Manager configuration** under `home-manager/`.
- **User config files** under `config/` (AwesomeWM, Neovim, tmux, rofi, zsh, etc.).
- **Shell helpers** under `bin/` used by widgets/keybinds and daily workflow.
- **`system` Python CLI** under `system_cli/` for setup/switch operations.
- **`journal.md`** with manual installation notes and system bring-up steps.
