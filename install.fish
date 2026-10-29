#!/usr/bin/env fish
# Deploy dotfiles on this machine: stow common + host package, then build wayfire.ini.
# Usage: ./install.fish [host]   (default: derived from the hostname)

set -l repo (path dirname (realpath (status filename)))
set -l host $argv[1]

if test -z "$host"
    switch (uname -n)
        case azur3x-xps
            set host xps
        case azur3x-desktop
            set host desktop
        case '*'
            echo "Unknown hostname "(uname -n)"; pass the host as an argument." >&2
            exit 1
    end
end

cd $repo; or exit 1
stow -v -R common $host; and python wayfire/build.py $host
