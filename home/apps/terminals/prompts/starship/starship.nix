{ pkgs, ... }:

{
  imports = [
    ./modules
  ];

  programs.starship = {
    enable = true;
  };
}
