{
  "custom/thm-cpu" = {
    exec = "$XDG_BIN_HOME/waybar/waybar-thermals.sh";
    return-type = "json";
    format = "△ {text}";
    tooltip = true;
    tooltip-format = "CPU";
    interval = 1;
  };
}
