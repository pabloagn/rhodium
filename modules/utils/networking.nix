{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    curl # Command line HTTP client
    dig # DNS lookup utility
    wget # Web file downloader
    wirelesstools # Wireless network configuration tools
    ipfetch
  ];
}
