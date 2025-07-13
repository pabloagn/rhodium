{ pkgs, ... }:
{
  imports = [
    ./bat.nix
    ./glow.nix
    # ./lf.nix
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
    miller # Like awk, sed, cut, join, and sort for data formats such as CSV, TSV, JSON,etc
    tree # Produce an indented directory tree view
    broot # Interactive tree view
    rich-cli # CLI for Python's rich
  ];
}
