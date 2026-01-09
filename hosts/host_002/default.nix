{
  host,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/apps
    ../../modules/boot/boot.nix
    ../../modules/desktop
    ../../modules/desktop/wm/niri/intel.nix
    ../../modules/hardware
    ../../modules/integration
    ../../modules/maintenance
    ../../modules/manager
    ../../modules/network
    ../../modules/rules
    ../../modules/security
    ../../modules/services
    ../../modules/shell
    ../../modules/users
    ../../modules/utils
    ../../modules/virtualization
    ../../modules/virtualization/docker-nvidia.nix
  ];

  # Base
  # ---------------------------------
  boot.kernelPackages = pkgs.linuxPackages_6_12;
  networking = {
    hostName = host.hostname or "nixos";
    networkmanager.enable = true;
  };


  # ---------------------------------------------------------------------------------

  # Modules
  # ---------------------------------
  extraServices = {
    asusKeyboardBacklight.enable = false;
    laptopLid.enable = false;
  };
  extraRules = {
    keychronUdev.enable = true;
    keychronQ3Udev.enable = true;
    hdmiAutoSwitch.enable = true;
  };
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
  system.stateVersion = "24.11";
}
