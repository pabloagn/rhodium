{ pkgs, ... }:
{
  home.packages = with pkgs; [
    discordo
    discord
  ];
}

