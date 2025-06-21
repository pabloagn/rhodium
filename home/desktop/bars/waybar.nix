{...}: {
  programs.waybar = {
    enable = true;
  };

  xdg.configFile."waybar/config.jsonc" = {
    source = ./waybar/config.jsonc;
    force = true;
  };

  xdg.configFile."waybar/style.css" = {
    source = ./waybar/style.css;
    force = true;
  };
}
