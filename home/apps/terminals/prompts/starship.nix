{ pkgs, ... }:

{
  imports = [
    ./starship
  ];

  programs.starship = {
    enable = true;
  };
}
