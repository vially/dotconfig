# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

This repository **is** `~/.config` (`$XDG_CONFIG_HOME`) itself — a personal dotfiles repo
version-controlled in place. The git working tree is the live config directory, so edits take
effect on the running system immediately; there is no checkout/deploy step. There is no build,
lint, or test suite. "Applying" a change means reloading the relevant program (see below).

Because the working tree is a huge directory full of application state, the repo tracks only a
hand-picked subset of files. `git ls-files` shows what is actually managed (mostly `fish/`,
`sway/`, `hypr/`, `systemd/`, `eww/`, plus assorted single-file configs). Everything else is
untracked or explicitly ignored.

## Adding / managing files

- `.gitignore` is a **denylist** that keeps accidental `git add .` from sweeping in app caches,
  credential stores, and runtime state. It does *not* auto-track new configs.
- To start tracking a new config, `git add <path>` it explicitly. If a parent directory is
  ignored, the add will be blocked — check `.gitignore` and add a negation/exception if the file
  genuinely belongs in the repo.
- Never commit secrets or runtime state. Existing ignore entries already exclude things like
  `Bitwarden CLI/`, `containers/auth.json`, `git/config.local`, `fish/fish_variables`, and the
  `*/conf.d/ephemeral/` dirs — follow that precedent for anything sensitive or machine-generated.

## Fish shell (`fish/`) — the largest tracked component

Layout follows fish's autoloading conventions; understanding the split matters:

- `conf.d/*.fish` — snippets sourced automatically on every shell start, one concern per file
  (`path.fish`, `git.fish`, `atuin.fish`, `theme.fish`, `zellij.fish`, …). Add startup wiring as
  a new focused file here rather than growing `config.fish`.
- `functions/*.fish` — lazily autoloaded; filename must match the function name. `config.fish`
  is intentionally near-empty.
- `completions/*.fish` — autoloaded completions, filename matches the command.
- `conf.d/abbr.fish` — central list of `abbr` abbreviations (shell shortcuts).
- `fish_plugins` / `fishfile` — Fisher plugin manifest. `fisher.fish` and the `_nvm_*` /
  `nvm.fish` functions are vendored plugin code; prefer updating via Fisher over hand-editing.

`envctl` (`functions/envctl.fish`) is a custom subcommand dispatcher: `envctl
activate|print|edit <name>` manages per-project env files under `~/.local/share/envctl/*.env`,
launching a subshell with those vars set. New subcommands are added as `__envctl_<name>`
functions.

Reload after edits: open a new shell, or `source` the changed file. New autoloaded
functions/completions are picked up on next use without a reload.

## Wayland compositors (`sway/`, `hypr/`)

Both use the same modular include pattern, and the repo carries configs for both (sway is the
older setup, hypr the newer one).

- Entry points are thin: `sway/config` and `hypr/hyprland.conf` just glob-include their
  `conf.d/` directories. Real configuration lives in the numbered/topic files under `conf.d/`
  (`input`, `keybindings`, `monitors`/`outputs`, `ui`, `swayidle`, …). Edit those, not the entry
  point.
- `conf.d/ephemeral/*` is included but **gitignored** — it holds machine/runtime-generated
  overrides. Don't commit it.
- sway additionally includes `conf.d/$(hostname)/*` for per-machine config (e.g.
  `conf.d/vially-desktop/`), so host-specific output/monitor settings stay isolated.
- `sway/conf.d/01-systemd.config` imports the Wayland environment into the systemd user manager
  and starts `sway-session.target`. This is the bridge between the compositor and the user
  services in `systemd/user/`.

Reload after edits: `swaymsg reload` / `hyprctl reload` (no logout needed for most changes).

## systemd user units (`systemd/user/`)

Tracked unit files (`gpg-agent`, `ssh-agent`, `swayidle`, `albert`, and the
`sway-session.target`) define the graphical session's user services. They are bound to
`sway-session.target`, which the compositor starts via the `01-systemd` glue above. The
`*.wants/`, generated `*.service`/`*.socket`, and symlinks are gitignored — only the canonical
unit definitions are tracked. After changing a unit: `systemctl --user daemon-reload` then
restart the relevant unit.

## Other notable tracked configs

- `git/config` is tracked; `git/config.local` (machine/identity overrides) is ignored and
  included from the main config.
- `eww/` (eww.yuck + eww.scss + scripts), `waybar/`, `darkman/`, `alacritty/`, `nvim/`,
  `starship.toml`, `containers/` (podman registries/config) are the remaining managed pieces.
- `install.sh` only symlinks `sway/scripts/assign_focused_window_to_ws` into `~/.local/bin/`;
  there is no broader installer — the repo *being* `~/.config` is the install mechanism.
