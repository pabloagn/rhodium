# modules/core/hardware/networking.nix

{ config, lib, pkgs, modulesPath, ... }:

{
  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;
}
