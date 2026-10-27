set -g fish_greeting ""
fish_add_path -g ~/.local/bin

if status is-interactive
    starship init fish | source

    # kitten ssh copies kitty's terminfo to the remote; only valid inside kitty
    if test "$TERM" = xterm-kitty
        alias ssh 'kitten ssh'
    end
end
