{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    curl # Command line HTTP client
    xh # A better curl
    dig # DNS lookup utility
    wget # Web file downloader
    wirelesstools # Wireless network configuration tools
    ipfetch
  ];
}
