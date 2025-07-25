{ pkgs, ... }:
{
  home.packages = with pkgs; [
    figma-linux # Unofficial Figma client for Linux
  ];
}

