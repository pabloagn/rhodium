{ pkgs, ... }:

{
  imports = [
    ./yazi/modules
  ];

  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
  };
}
