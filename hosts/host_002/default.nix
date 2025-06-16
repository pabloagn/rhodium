{
  host,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/boot/boot.nix
    ../../modules/services
    ../../modules/hardware
    ../../modules/shell
    ../../modules/security
    ../../modules/users
    ../../modules/manager
    ../../modules/desktop
    ../../modules/desktop/wm/hyprland/intel.nix
    ../../modules/virtualization
    ../../modules/apps
    ../../modules/maintenance
    ../../modules/utils
  ];

  # Kernel version
  boot.kernelPackages = pkgs.linuxPackages_6_12; # Courtesy of fucking NVIDIA, they dont support latest kernel yet.

  # Host Configuration
  networking = {
    hostName = host.hostname or "nixos";
    networkmanager.enable = true;
  };

  # Extra Services
  services = {
    asusKeyboardBacklight.enable = false;
    laptopLid.enable = false;
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
  system.stateVersion = "24.11";
}
