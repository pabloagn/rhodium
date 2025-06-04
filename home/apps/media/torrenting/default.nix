{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # transmission_4-qt # Transmission GUI
    qbittorrent
  ];
}
