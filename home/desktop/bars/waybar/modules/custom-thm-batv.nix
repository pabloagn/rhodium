{
  waybarModules = {
    "custom/thm-batv" = {
      exec = "$XDG_BIN_HOME/waybar/custom-thermals.sh batv";
      return-type = "json";
      format = "B {text}";
      tooltip = true;
      tooltip-format = "Battery Voltage";
      interval = 1;
    };
  };
}
