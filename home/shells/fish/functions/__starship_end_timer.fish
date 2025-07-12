function __starship_end_timer --on-event fish_prompt
    set -l start_ms $STARSHIP_CMD_START_EPOCH_MS
    if test -n "$start_ms"
        set -l end_ms (gdate +%s%3N)
        set -l delta_ms (math "$end_ms - $start_ms")

        # NOTE: We use the 5000 miliseconds for 5 seconds (geq)
        if test $delta_ms -ge 5000
            set -l minutes (math "floor($delta_ms / 60000)")
            set -l seconds (math "floor(($delta_ms % 60000) / 1000)")
            set -gx STARSHIP_CUSTOM_DURATION "$minutes"m"$seconds"s

            set -l start_epoch_s (math "floor($start_ms / 1000)")
            set -l end_epoch_s (math "$start_epoch_s + $minutes * 60 + $seconds")

            set -gx STARSHIP_CUSTOM_START (gdate -d "@$start_epoch_s" "+%T")
            set -gx STARSHIP_CUSTOM_END (gdate -d "@$end_epoch_s" "+%T")
        else
            set -e STARSHIP_CUSTOM_DURATION
            set -e STARSHIP_CUSTOM_START
            set -e STARSHIP_CUSTOM_END
        end
    end
end

