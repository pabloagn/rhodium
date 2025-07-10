{
  waybarModules = {
    memory = {
      interval = 2;
      format = "𝍖 {percentage}%";
      format-alt = "𝍖 {percentage}% {icon}";
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
        𝍖 RAM
        ━━━━━━━━━━━━━━━━━━
        • Usage ⟶ {used} / {total} ({percentage}%)
        • Available ⟶ {avail}
      '';
      on-click-right = "$XDG_BIN_HOME/launchers/launchers-btop.sh";
    };
  };
}
