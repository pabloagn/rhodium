{
  config,
  lib,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/hardware/network/broadcom-43xx.nix")
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "thunderbolt"
      "usb_storage"
      "sd_mod"
    ];
    initrd.kernelModules = [ "amdgpu" ];

    # AMD + Realtek (WiFi)
    kernelModules = [
      "kvm-amd"
      "rtw89"
      "usbhid"
    ];

    # Wayland-related requirements
    kernelParams = [
      "amdgpu.dc=1" # Enable Display Core for advanced color management
      # "amdgpu.ppfeaturemask=0xffffffff" # Enable all power/display features
      # DISABLED: ppfeaturemask=0xffffffff enables GFXOFF (bit 15) and aggressive power/clock
      # gating, which makes the GPU unable to service DRM requests during transient PCI fabric
      # disruptions (e.g. USB disconnect from ESD on Keychron Q3 metallic keyboard on the same
      # PCI root 08.x as the GPU).
      # See: coredumpctl list — every Slack/1Password SIGTRAP correlates with usb 3-2 disconnect.
      # Refs: Arch Wiki AMDGPU, Electron #45862, kernel GFXOFF+PG patch for GFX9 APUs
      # Bit math (verified against drivers/gpu/drm/amd/include/amd_shared.h):
      #   Kernel default = 0xfff7bfff (bits 14 PP_OVERDRIVE and 19 PP_GFX_DCS OFF by design)
      #   0xfff7bfff & ~0x8000 (GFXOFF, bit 15) & ~0x20000 (STUTTER, bit 17) = 0xfff53fff
      "amdgpu.ppfeaturemask=0xfff53fff" # Kernel default minus GFXOFF (bit 15) and stutter (bit 17)
      "amdgpu.runpm=0" # Explicitly disable runtime PM (redundant on APU but defense-in-depth)
      "amdgpu.dcdebugmask=0x12" # Disable PSR (0x10) + stutter (0x2) to prevent HDMI blanking
      "usbcore.autosuspend=-1" # Disable USB autosuspend globally to reduce ESD sensitivity on xHCI
    ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/a729d1fd-92c8-4803-9f4b-a3ee9aee5aac";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/EFAB-C786";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/5d21ee96-9219-40e1-b665-f26c580b19b7"; } ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  powerManagement.cpuFreqGovernor = "performance";
}
