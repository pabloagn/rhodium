# hosts/rhodium-wsl/default.nix

{ config, lib, pkgs, hostname, ... }:

{
  # WSL-specific configuration
  wsl = {
    enable = true;
    defaultUser = "nixos";
    startMenuLaunchers = true;
    nativeSystemd = true;
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
}
