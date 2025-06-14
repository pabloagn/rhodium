function vw --description "Neovim with automatic fullscreen padding"
    kitty @ set-spacing padding=0
    command nvim $argv
    set -l exit_status $status
    kitty @ set-spacing padding=10 padding=15 padding=15 padding=15
    return $exit_status
end
