{
  waybarModules = {
    "custom/thm-amb" = {
      exec = "$XDG_BIN_HOME/waybar/waybar-thermals.sh amb";
      return-type = "json";
      format = "A {text}";
      tooltip = true;
      tooltip-format = "Ambient";
      interval = 1;
    };
  };
}
