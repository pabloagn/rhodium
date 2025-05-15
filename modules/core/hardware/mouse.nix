# modules/core/hardware/mouse.nix

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Solaar NixOS utility for connecting Logitech devices to receivers
    solaar
  ];
}
