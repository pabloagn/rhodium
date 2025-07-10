{
  "custom/thm-batv" = {
    exec = "$XDG_BIN_HOME/waybar/waybar-thermals.sh batv";
    return-type = "json";
    format = "B {text}";
    tooltip = true;
    tooltip-format = "Battery Voltage";
    interval = 1;
  };
}

