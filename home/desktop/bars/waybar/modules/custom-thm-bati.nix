{
  waybarModules = {
    "custom/thm-bati" = {
      exec = "$XDG_BIN_HOME/waybar/custom-thermals.sh bati";
      return-type = "json";
      format = "B {text}";
      tooltip = true;
      tooltip-format = "Battery Current";
      interval = 1;
    };
  };
}
