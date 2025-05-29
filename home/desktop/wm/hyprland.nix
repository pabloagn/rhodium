{ pkgs, ... }:

{
  imports = [
    ./hyprland
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
  };
}
