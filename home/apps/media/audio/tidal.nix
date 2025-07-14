{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tidal-dl # Downloader for tidal media
    tidal-hifi # Tidal GUI running on Electron
  ];
}
