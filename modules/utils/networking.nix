{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    curl # Command line HTTP client
    dig # DNS lookup utility
    ipfetch # Neofetch for IP addresses
    wget # Web file downloader
    wirelesstools # Wireless network configuration tools
    xh # A better curl
  ];
}
