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
    keychronQ3Udev.enable = true;
    hdmiAutoSwitch.enable = false;
    netgearA8000Udev.enable = true;
    bluetoothNoPowerSave.enable = true;
  };

  # Garbage override
  maintenance.garbageCollection = {
    enable = true;
    schedule = "daily";
    deleteOlderThan = "30d";
  };

  # VM / Memory tuning
  # ---------------------------------
  boot.kernel.sysctl = {
    "vm.swappiness" = 10; # Strongly prefer RAM over swap (default 60 causes swap-thrashing)
    "vm.vfs_cache_pressure" = 50; # Keep dentries/inodes cached longer
  };

  # Enable zram for compressed in-memory swap (much faster than disk swap)
  zramSwap = {
    enable = true;
    memoryPercent = 50; # Use up to 50% of RAM for compressed swap
    algorithm = "zstd";
    priority = 100; # Higher priority than disk swap (-2)
  };

  # ASUS platform power management
  # Switch to performance profile on AC, balanced on battery
  services.udev.extraRules = ''
    ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", \
      RUN+="${pkgs.bash}/bin/bash -c 'echo performance > /sys/firmware/acpi/platform_profile; echo 1 > /sys/devices/platform/asus-nb-wmi/throttle_thermal_policy'"
    ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", \
      RUN+="${pkgs.bash}/bin/bash -c 'echo balanced > /sys/firmware/acpi/platform_profile; echo 0 > /sys/devices/platform/asus-nb-wmi/throttle_thermal_policy'"
  '';

  # Set performance profile on boot (usually plugged in)
  systemd.services.asus-performance-profile = {
    description = "Set ASUS platform profile to performance on AC";
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-modules-load.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.bash}/bin/bash -c 'if [ \"$(cat /sys/class/power_supply/AC0/online 2>/dev/null || cat /sys/class/power_supply/ACAD/online 2>/dev/null || echo 0)\" = \"1\" ]; then echo performance > /sys/firmware/acpi/platform_profile; echo 1 > /sys/devices/platform/asus-nb-wmi/throttle_thermal_policy; fi'";
    };
  };

  # Extra Args
  # ---------------------------------
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "24.05"; # NOTE: Original derivation
}
