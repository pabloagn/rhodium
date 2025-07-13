{ pkgs, ... }:
{
  home.packages = with pkgs; [
    protonvpn-cli
    protonvpn-gui
  ];
}
