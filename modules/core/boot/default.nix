# modules/core/boot/default.nix

{ config, lib, pkgs, hostData, ... }:

with lib;
let
  cfg = config.rhodium.system.core.boot;
  hw = hostData.hardware or { };
  hwCpu = hw.cpu or { };
  hwGfxDiscrete = hw.graphics.discreteGPU or { };
  hwGfxIntegrated = hw.graphics.integratedGPU or { };
  hwNetWifi = hw.network.wifi or { };
  hwNetEthernet = hw.network.ethernet or { };
  hwNetBluetooth = hw.network.bluetooth or { };
  hwPorts = hw.ports or { };
  hwInput = hw.input or { };
  hwMemoryStorage = hw.memory.storage or [ ];

  # Determine which GPU is considered primary for KMS and driver loading
  primaryGpuVendor = hwGfxDiscrete.vendor or hwGfxIntegrated.vendor or null;
  primaryGpuDriverType = hwGfxDiscrete.driverType or hwGfxIntegrated.driverType or null;

in
{
  options.rhodium.system.core.boot = {
    enable = mkEnableOption "Rhodium boot configuration";

    loader.systemd-boot.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable systemd-boot as the bootloader.";
    };

    loader.efi.canTouchEfiVariables = mkOption {
      type = types.bool;
      default = true;
      description = "Allow touching EFI variables (needed for systemd-boot).";
    };

    kernelPackage = mkOption {
      type = types.package;
      default = pkgs.linuxPackages_latest;
      defaultText = literalExpression "pkgs.linuxPackages_latest";
      description = "The kernel package to use.";
      example = literalExpression "pkgs.linuxPackages_zen";
    };

    initrd.availableKernelModules = mkOption {
      type = types.listOf types.str;
      default = [ "xhci_pci" "usb_storage" "sd_mod" ];
      description = "List of available kernel modules for initrd (early boot). Customize per host if needed.";
    };

    initrd.kernelModules = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Kernel modules to load in initrd (e.g., GPU drivers). Customize per host.";
    };

    kernelModules = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Kernel modules to load by the main system. Customize per host.";
    };

    extraModulePackages = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Extra kernel module packages.";
    };

    nvidia = {
      enable = mkEnableOption "NVIDIA proprietary driver setup (if NVIDIA GPU present)";
      kernelPackageSet = mkOption { type = types.package; default = config.boot.kernelPackages.nvidiaPackages.stable; };
      modesetting = mkEnableOption "NVIDIA modesetting";
      earlyKmsModules = mkOption {
        type = types.listOf types.str;
        default = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
        description = "NVIDIA modules for early KMS when modesetting is enabled.";
      };
    };

  };

  config = mkIf cfg.enable {
    boot.loader.systemd-boot.enable = cfg.loader.systemd-boot.enable;
    boot.loader.efi.canTouchEfiVariables = cfg.loader.efi.canTouchEfiVariables;
    boot.kernelPackages = cfg.kernelPackage;
    boot.extraModulePackages = cfg.extraModulePackages;

    boot.initrd.availableKernelModules = lib.unique (
      cfg.initrd.availableKernelModules ++
      (optional (hwPorts.hasThunderbolt or false) "thunderbolt")
        # NVMe is usually included in general initramfs builds or by mkDefault in NixOS if root is NVMe.
        # Adding it here ensures it's considered if not automatically picked up.
        (optional (any (s: s.type == "nvme") hwMemoryStorage) "nvme")
    );

    boot.initrd.kernelModules = lib.unique (
      cfg.initrd.kernelModules ++
      (optional (primaryGpuVendor == "amd") "amdgpu") ++
      (optional (primaryGpuVendor == "intel") "i915") ++
      (if (primaryGpuVendor == "nvidia" && cfg.nvidia.enable && cfg.nvidia.modesetting.enable) then
        cfg.nvidia.earlyKmsModules
      else [ ])
    );

    boot.kernelModules = lib.unique (
      cfg.kernelModules
      ++ (optional (hwCpu.vendor == "amd") "kvm-amd")
      ++ (optional (hwCpu.vendor == "intel") "kvm-intel")
      # ++ (optional (hwNetWifi.driver != null && hwNetWifi.driver != "") hwNetWifi.driver)
      # ++ (optional (hwNetEthernet.driver != null && hwNetEthernet.driver != "") hwNetEthernet.driver)
      # ++ (optional (hwNetBluetooth.driver != null && hwNetBluetooth.driver != "") hwNetBluetooth.driver)
    );

    # NVIDIA proprietary driver configuration
    hardware.nvidia = mkIf (primaryGpuVendor == "nvidia" && cfg.nvidia.enable) {
      modesetting.enable = cfg.nvidia.modesetting.enable;
    };
    # This ensures the correct Xorg driver is selected if NVIDIA is primary and enabled
    services.xserver.videoDrivers = mkIf (primaryGpuVendor == "nvidia" && cfg.nvidia.enable) [ "nvidia" ];
  };
}
