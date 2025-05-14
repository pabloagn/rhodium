# hosts/nixos-native/default.nix

{ config, pkgs, lib, hostname, ... }:

{
  imports = [
    ../common/default.nix
    # TODO: Pending hardware-configuration.nix
  ];

  networking.hostName = hostname;
  # TODO: State needs to be defined from flakes directly.
  system.stateVersion = "23.11";

  programs.wayland.enable = true;

  mySystem.hostProfile = lib.mkDefault "tiling-desktop";
  mySystem.hardware.amdGpu = lib.mkDefault true; # Example if this desktop usually has AMD
}
