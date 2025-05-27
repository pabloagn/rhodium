{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    lf
  ];
}
