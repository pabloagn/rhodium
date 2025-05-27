{ config, pkgs, pkgs-unstable, ... }:
{
  programs.yazi = {
    enable = true;
    package = pkgs-unstable.yazi;
  };
}
