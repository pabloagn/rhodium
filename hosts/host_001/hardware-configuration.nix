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
      "amdgpu.ppfeaturemask=0xffffffff" # Enable all power/display features
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
