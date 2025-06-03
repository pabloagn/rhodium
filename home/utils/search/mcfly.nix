{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mcfly
  ];
}
