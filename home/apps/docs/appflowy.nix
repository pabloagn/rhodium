{ pkgs, ... }:
{
  home.packages = with pkgs; [
    appflowy
  ];
}
