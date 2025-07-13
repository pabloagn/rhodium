{ pkgs, ... }:
{
  home.packages = with pkgs; [
    plex
    plexamp
  ];
}
