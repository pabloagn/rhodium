{...}: {
  xdg.configFile."niri/config.kdl" = {
    source = ./niri/config.kdl;
    force = true;
  };
}
