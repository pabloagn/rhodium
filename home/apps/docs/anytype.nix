{ pkgs, ... }:
{
  home.packages = with pkgs; [
    anytype
  ];
}
