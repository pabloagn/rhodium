{...}: {
  xdg.configFile."niri/config.kdl" = {
    source = ./niri/config.kdl;
    force = true; # This is so that we don't break niri while switching
  };
}
