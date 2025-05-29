{ pkgs, ... }:
# TODO: Config theme, etc
{
  home.packages = with pkgs; [
    glow
  ];
}
