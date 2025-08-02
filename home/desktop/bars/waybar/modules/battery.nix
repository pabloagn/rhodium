{
  waybarModules = {
    battery = {
      interval = 1;
      # bat = "BAT0";
      bat = "BAT1";
      states = {
        good = 95;
        warning = 30;
        critical = 15;
      };
      on-click-right = "$XDG_BIN_HOME/fuzzel/fuzzel-power.sh";
      format = "Ω {capacity}%";
      format-alt = "Ω {capacity}% {icon}";
      format-charging = "{capacity}% 𝥽";
      format-plugged = "{capacity}% 𝥽";
      format-icons = [
        "[⠀]"
        "[⢀]"
        "[⣀]"
        "[⣠]"
        "[⣤]"
        "[⣴]"
        "[⣶]"
        "[⣾]"
        "[⣿]"
      ];
      tooltip = true;
      tooltip-format = ''
        Ω Battery
        ━━━━━━━━━━━━━━━━━━
        • Battery ⟶ {capacity}%
        • Power Draw ⟶ {power}W
        • Time Remaining ⟶ {time}
        • Health ⟶ {health}%
        • Charge Cycles ⟶ {cycles}
      '';
      tooltip-format-charging = ''
        Ω Battery
        ━━━━━━━━━━━━━━━━━━
        • Battery ⟶ {capacity}% [𝥽 Charging]
        • Power Input ⟶ {power}W
        • Time to Full ⟶ {time}
        • Health ⟶ {health}%
        • Charge Cycles ⟶ {cycles}
      '';
      tooltip-format-plugged = ''
        Ω Battery
        ━━━━━━━━━━━━━━━━━━
        • Battery ⟶ {capacity}% [𝥽 Plugged]
        • Power Draw ⟶ {power}W
        • Health ⟶ {health}%
        • Charge Cycles ⟶ {cycles}
      '';
      tooltip-format-full = ''
        Ω Battery
        ━━━━━━━━━━━━━━━━━━
        • Battery ⟶ {capacity}% [● Full]
        • Power Draw ⟶ {power}W
        • Health ⟶ {health}%
        • Charge Cycles ⟶ {cycles}
      '';
    };
  };
}
