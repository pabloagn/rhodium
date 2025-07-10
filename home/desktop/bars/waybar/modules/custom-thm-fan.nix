{
  waybarModules = {
    "custom/thm-fan" = {
      exec = "$XDG_BIN_HOME/waybar/custom-thermals.sh fan";
      return-type = "json";
      format = " {text}";
      interval = 1;
    };
  };
}
