{
  host,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/boot/boot.nix
    ../../modules/services
    ../../modules/services/dbus.nix # Required for niri # TODO: Pass as conditional with Niri enable
    ../../modules/hardware
    ../../modules/shell
    ../../modules/security
    ../../modules/users
    ../../modules/manager
    # Window Manager
    ../../modules/desktop
    # ../../modules/desktop/wm/hyprland/amd.nix
    ../../modules/desktop/wm/niri/amd.nix

    ../../modules/virtualization
    ../../modules/apps
    ../../modules/maintenance
    ../../modules/utils
  ];

  # Kernel version (AMD follows latest)
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Host Configuration
  networking = {
    hostName = host.hostname or "nixos";
    networkmanager.enable = true;
  };

  # Modules
  # Display Manager
  manager = {
    gdm.enable = true;
  };

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
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Original derivation
  system.stateVersion = "24.05";
}
