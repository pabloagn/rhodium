{ config, pkgs, pkgs-unstable, users, host, ... }:

{
  imports = [
    ./hardware-configuration.nix

    # Modules - Boot
    ../../modules/boot/boot.nix

    # Modules - Services
    ../../modules/services

    # Modules - Hardware
    ../../modules/hardware

    # Modules - Shell
    ../../modules/shell

    # Security
    ../../modules/security/keyrings.nix
    ../../modules/security/sops.nix

    # Modules - Users
    ../../modules/users

    # Modules - Desktop
    ../../modules/desktop
    ../../modules/desktop/wm/hyprland/amd.nix

    # Modules - Virtualization
    ../../modules/virtualization

    # Modules - Apps
    ../../modules/apps

    # Modules - Maintenance
    ../../modules/maintenance

    # Modules - Utils
    ../../modules/utils
  ];

  # Host Configuration
  # -------------------------
  networking = {
    hostName = host.hostname or "nixos";
    networkmanager.enable = true;
  };

  # Options
  # -------------------------

  # Extra Services
  services = {
    asusKeyboardBacklight.enable = true;
    laptopLid.enable = true;
  };

  # Garbage override
  maintenance.garbageCollection = {
    enable = true;
    schedule = "daily";
    deleteOlderThan = "30d";
  };

  # Extra Args
  # TODO: Check if this is still required, and/or if this is the correct way to do it (here)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Original derivation
  # We can leave as is perpetually
  system.stateVersion = "24.05";
}
