{ pkgs, ... }:

{
  imports = [
    ./bat.nix
    ./glow.nix
    ./lf.nix
    ./nnn.nix
    ./yazi.nix
  ];

  programs = {
    eza = {
      enable = true;
    };
    zoxide = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    desktop-file-utils # Command line utilities for working with .desktop files
    most # Pager
    less # Pager
  ];
}
