{ pkgs, ... }:
{
  home.packages = with pkgs; [
    imv # Image visualizer (Wayland)
  ];

  xdg.configFile = {
    "imv/config" = {
      source = ./imv/config;
    };
  };
}
