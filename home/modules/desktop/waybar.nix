{ config, pkgs, lib, ... }: {
  programs.waybar = {
    enable = true;
  };
  xdg.configFile."waybar/config.jsonc" = {
    source = ./config.jsonc;
  };

  xdg.configFile."waybar/style.css" = {
    source = ./style.css;
  };
}
