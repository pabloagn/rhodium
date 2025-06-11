{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kitty # Kitty is always installed (required by hyprland)
  ];
}
