# modules/core/hardware/wifi.nix

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
