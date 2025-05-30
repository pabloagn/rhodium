{ pkgs, ... }:

{
  imports = [
    ./kakoune
  ];

  programs.kakoune = {
    enable = true;
    # package = pkgs.kakoune; # This caused problems
  };
}
