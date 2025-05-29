{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    xfce.thunar
  ];
}
