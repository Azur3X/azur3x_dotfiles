# azur3x_dotfiles

Arch + Wayfire dotfiles for two machines (XPS laptop and desktop), managed with GNU Stow.

## Layout

- `common/` — configs shared by both machines, stowed into `~`
- `xps/`, `desktop/` — host-only files (e.g. waybar's `host.jsonc`)
- `wayfire/` — `base.ini` + `hosts/<host>.ini`, merged by `build.py` into `~/.config/wayfire.ini`
- `walls/` — wallpapers

## Install or update

    ./install.fish

Stows `common` plus this machine's package and rebuilds `wayfire.ini`.

## Editing

- Stowed configs are symlinks into this repo: edit in place, commit, push, then `git pull` on the other machine.
- Wayfire: edit `wayfire/base.ini` or `wayfire/hosts/<host>.ini`, then run `./install.fish`. Never edit `~/.config/wayfire.ini` directly; it is generated.
- New config: put it under `common/.config/<app>` (or a host package), move the existing one aside, run `./install.fish`.

## Not in this repo

System files under `/etc` are per host: the swaylock PAM stacks, howdy, and the IR emitter config.
