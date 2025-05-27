{ pkgs, ... }:

{
  home.packages = with pkgs; [

  # VPN
  # ------------------------------------------
  protonvpn-cli
  protonvpn-gui
  ];
}

