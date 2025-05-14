# hosts/nixos-desktop/default.nix

{ config, lib, pkgs, hostname, ... }:

{
  # Desktop-specific configuration
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Use system state version 24.11
  system.stateVersion = "24.11";

  # Networking configuration
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };

  # Set time zone
  time.timeZone = "Europe/London";

  # Set locale
  i18n.defaultLocale = "en_GB.UTF-8";

  # Enable X11 windowing system
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Enable sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;
}
