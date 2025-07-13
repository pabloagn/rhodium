{ pkgs, ... }:
{
  home.packages = with pkgs; [
    notion-app
  ];
}
