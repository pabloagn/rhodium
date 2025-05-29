{ config, pkgs, ... }:

{
  imports = [
    ./btop
  ];

  programs.btop = {
    enable = true;
  };
}
