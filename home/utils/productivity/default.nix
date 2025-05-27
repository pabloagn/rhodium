{ pkgs, ... }:
{
  home.packages = with pkgs; [
    slurp
    grim
    imagemagick
    swappy
    wl-clipboard
  ];
}
