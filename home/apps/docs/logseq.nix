{ pkgs, ... }:
{
  home.packages = with pkgs; [
    logseq
  ];
}
