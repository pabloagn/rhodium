{
  "custom/thm-amd" = {
    exec = "$XDG_BIN_HOME/waybar/waybar-thermals.sh amd";
    return-type = "json";
    format = "G {text}";
    tooltip = true;
    tooltip-format = "AMD GPU";
    interval = 1;
  };
}

