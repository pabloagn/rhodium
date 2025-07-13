{ pkgs, ... }:
{
  home.packages = with pkgs; [
    qbittorrent
  ];
}
