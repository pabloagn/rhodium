{ pkgs, ... }:
{
  home.packages = with pkgs; [
    joplin
    joplin-desktop
  ];
}
