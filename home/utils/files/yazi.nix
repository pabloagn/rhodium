{ pkgs, pkgs-unstable, ... }:
{
  imports = [
    ./yazi/modules
  ];

  programs.yazi = {
    enable = true;
    # package = pkgs.yazi;
    package = pkgs-unstable.yazi; # Using unstable for now due to some plugin requirements
    };
  }
