# hosts/nixos-desktop/default.nix

{ config, pkgs, lib, hostname, ... }:

{
  imports = [
    ../common/default.nix
    ./hardware-configuration.nix # If we generate one for this native host
  ];

  networking.hostName = hostname;
  system.stateVersion = "23.11";

  # For a native desktop, enable Xserver or Wayland session management basics
  services.xserver.enable = true; # Or programs.wayland.enable = true;
  services.xserver.displayManager.startx.enable = true; # Basic startx, or choose gdm, sddm etc.

  mySystem.hostProfile = lib.mkDefault "gui-desktop";
  mySystem.hardware.amdGpu = lib.mkDefault true; # Example if this desktop usually has AMD
}
