{ pkgs, ... }:
{
  home.packages = with pkgs; [
    sonic-pi
  ];
}
