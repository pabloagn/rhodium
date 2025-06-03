{ pkgs, ... }:

{
  home.packages = with pkgs; [
    skim
  ];
}
