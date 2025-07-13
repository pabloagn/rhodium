{ pkgs, ... }:
{
  home.packages = with pkgs; [
    krusader
  ];
}
