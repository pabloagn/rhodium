function __starship_end_timer --on-event fish_prompt
    set -l start_ms $STARSHIP_CMD_START_EPOCH_MS
    set -l end_ms (gdate +%s%3N)
    if test -n "$start_ms"
        set -l delta_ms (math "$end_ms - $start_ms")
        set -l minutes (math "floor($delta_ms / 60000)")
        set -l seconds (math "floor(($delta_ms % 60000) / 1000)")
        set -gx STARSHIP_CUSTOM_DURATION "$minutes"m"$seconds"s
        set -l end_epoch_s (math "floor($start_ms / 1000) + $minutes * 60 + $seconds")
        set -gx STARSHIP_CUSTOM_END (gdate -d "@$end_epoch_s" "+%T")
    end
end
