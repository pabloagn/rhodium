{
  waybarModules = {
    "custom/thm-nvme" = {
      exec = "$XDG_BIN_HOME/waybar/waybar-thermals.sh nvme";
      return-type = "json";
      format = "N {text}";
      tooltip = true;
      tooltip-format = "NVME";
      interval = 1;
    };
  };
}
