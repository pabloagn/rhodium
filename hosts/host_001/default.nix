{
  host,
  pkgs,
  ...
}:
{
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
    ../../modules/desktop/wm/niri/amd.nix
    ../../modules/integration
    ../../modules/virtualization
    ../../modules/virtualization/docker-amd.nix
    ../../modules/apps
    ../../modules/rules
    ../../modules/maintenance
    ../../modules/utils
    ../../modules/network
  ];

  # Base
  # ---------------------------------
  # Kernel version
  # BUG: Latest Kernel has fundamental issues with ASUS BIOS
  # causing it to not get past EFI Stubs on boot (ACPI issue most likely)
  # The issue was bypassed by booting the machine connected to AC
  # using the NORMAL USB-C port (not the high-speed one)
  # For now, we're pinning the Kernel to the latest stable on this host.
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackages_6_12;

  # Host Configuration
  networking = {
    hostName = host.hostname or "nixos";
    networkmanager.enable = true;
  };

  # Modules
  # ---------------------------------
  # Display Manager
  manager = {
    gdm.enable = false;
  };

  # Extra Services
  extraServices = {
    asusKeyboardBacklight.enable = true;
    laptopLid.enable = true;
  };

  # Extra rules
  extraRules = {
    keychronUdev.enable = true;
    hdmiAutoSwitch.enable = true;
  };

  # Garbage override
  maintenance.garbageCollection = {
    enable = true;
    schedule = "daily";
    deleteOlderThan = "30d";
  };

  # Extra Args
  # ---------------------------------
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "24.05"; # NOTE: Original derivation
}
