{
  waybarModules = {
    cpu = {
      interval = 1;
      format = "⚙ {usage}%";
      format-alt = "⚙ U {usage}% L {load}% AVG {avg_frequency}GHz MAX {max_frequency}GHz MIN {min_frequency}GHz";
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
      on-click-right = "$XDG_BIN_HOME/launchers/launchers-btop.sh";
    };
  };
}
