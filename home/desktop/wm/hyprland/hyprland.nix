{ pkgs, ... }:

{
  imports = [
    ./modules
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
  };
}
