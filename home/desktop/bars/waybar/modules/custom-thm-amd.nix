{
  waybarModules = {
    "custom/thm-amd" = {
      exec = "$XDG_BIN_HOME/waybar/custom-thermals.sh amd";
      return-type = "json";
      format = "G {text}";
      tooltip = true;
      tooltip-format = "AMD GPU";
      interval = 1;
    };
  };
}
