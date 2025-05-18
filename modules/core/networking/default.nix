# modules/core/networking/default.nix

{ config, lib, pkgs, ... }:

{
  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  services.network-manager-applet.enable = true;
}
