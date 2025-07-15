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
    ../../modules/apps
    ../../modules/rules
    ../../modules/maintenance
    ../../modules/utils
  ];

  # Base
  # ---------------------------------
  # Kernel version (AMD follows latest)
  boot.kernelPackages = pkgs.linuxPackages_latest;

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

  environment.etc."kmonad/justine.kbd".source = ../../modules/desktop/keyboard/kmonad/justine.kbd;
  environment.etc."kmonad/keychron.kbd".source = ../../modules/desktop/keyboard/kmonad/justine.kbd;

  # Extra Services
  extraServices = {
    asusKeyboardBacklight.enable = true;
    laptopLid.enable = true;
    rh-kmonad = {
      enable = true;
      internalConfigFile = /etc/kmonad/justine.kbd;
      keychronConfigFile = /etc/kmonad/keychron.kbd;
    };
  };

  # Extra rules
  extraRules = {
    keychronUdev.enable = true;
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
