{...}: {
  services.mako = {
    enable = true;
  };

  xdg.configFile."mako/config" = {
    source = ./mako/config;
    force = true;
  };
}
