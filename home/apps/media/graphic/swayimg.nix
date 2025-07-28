{ pkgs, ... }:
{
  home.packages = with pkgs; [
    swayimg # Image visualizer supporting transformations (Wayland)
  ];

  xdg.configFile = {
    "swayimg/config" = {
      source = ./swayimg/config;
    };
  };
}
