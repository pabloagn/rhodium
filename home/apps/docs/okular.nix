{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.okular
  ];
}
