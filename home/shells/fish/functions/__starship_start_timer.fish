function __starship_start_timer --on-event fish_preexec
    set -gx STARSHIP_CMD_START_EPOCH_MS (gdate +%s%3N)
end
