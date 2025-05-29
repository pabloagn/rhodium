{ pkgs, ... }:
{
  home.packages = with pkgs; [
    texmaker
  ];
}
