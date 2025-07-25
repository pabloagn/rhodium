{ pkgs, ... }:
{
  home.packages = with pkgs; [
    inkscape # Vector graphics editor
  ];
}

