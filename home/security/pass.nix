{ pkgs, ... }:

{
  home.packages = with pkgs; [

  # Managers
  _1password-gui
  _1password-cli
  ];
}

