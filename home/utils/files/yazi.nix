{ pkgs, ... }:

{
  imports = [
    ./yazi
  ];

  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
  };
}
