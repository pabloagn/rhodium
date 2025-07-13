{ pkgs, ... }:
{
  home.packages = with pkgs; [
    swaybg # Wallpaper daemon
  ];
}
