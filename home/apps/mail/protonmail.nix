{ pkgs, ... }:
{
  home.packages = with pkgs; [
    protonmail-desktop
  ];
}

