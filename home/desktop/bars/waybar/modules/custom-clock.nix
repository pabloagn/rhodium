{
  waybarModules = {
    "custom/clock" = {
      exec = "$XDG_BIN_HOME/waybar/custom-clock.sh";
      return-type = "json";
      interval = 1;
      on-scroll-up = "$XDG_BIN_HOME/waybar/custom-clock-control.sh up";
      on-scroll-down = "$XDG_BIN_HOME/waybar/custom-clock-control.sh down";
      on-click = "$XDG_BIN_HOME/waybar/custom-clock-control.sh up";
      on-click-right = "$XDG_BIN_HOME/waybar/custom-clock-control.sh down";
      smooth-scrolling-threshold = 2.0;
    };
  };

  extraOptions = {
    xdg.dataFile."waybar/modules/custom-clock/timezones.json" = {
      source = ./custom-clock/timezones.json;
      force = true;
    };
  };
}
