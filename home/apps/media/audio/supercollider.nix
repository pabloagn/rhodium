{ pkgs, ... }:
{
  home.packages = with pkgs; [
    supercollider
  ];
}
