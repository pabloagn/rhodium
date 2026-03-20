function cc --description "Launch Claude Code with session name in kitty tab bar"
    if test (count $argv) -ge 1
        set -l session_name $argv[1]
        set -l remaining_args $argv[2..]
        kitty @ set-option tab_bar_min_tabs 1
        kitty @ set-tab-title "claude: $session_name"
        command claude --name "$session_name" $remaining_args
    else
        command claude $argv
    end
end
