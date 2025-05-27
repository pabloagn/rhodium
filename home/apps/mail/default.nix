{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # thunderbird
    protonmail-bridge
    protonmail-bridge-gui
    protonmail-desktop
  ];
}
