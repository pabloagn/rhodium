function yw --description "Yazi with automatic fullscreen padding"
    kitty @ set-spacing padding=0
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    set -l exit_status $status
    if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
    kitty @ set-spacing padding=10 padding=15 padding=15 padding=15
    return $exit_status
end
