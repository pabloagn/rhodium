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
    csvkit # Toolkit for tabular file processing
    xlsx2csv # Lightweight toolkit for tabular file processing
    duckdb # Embeddable SQL OLAP database (required for yazi duckdb plugin)
    ranger # VIM-inspired file manager
    xplr # Hackable, minimal file explorer
    visidata # Terminal spreadsheet multitool for tabular data
  ];
}
