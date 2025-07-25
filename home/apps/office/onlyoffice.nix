{ pkgs, ... }:
{
  home.packages = with pkgs; [
    onlyoffice-desktopeditors
  ];
}

