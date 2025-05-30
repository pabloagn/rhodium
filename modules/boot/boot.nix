{ pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Added stability for AMD Strix Architectures
#  boot.kernelParams = [
#    "amdgpu.dc=0"              # Disable Display Core (most important)
#    "amdgpu.gpu_recovery=1"    # Enable GPU recovery
#    "amdgpu.runpm=0"           # Disable runtime power management
#    "amdgpu.dpm=0"             # Disable dynamic power management
#  ];
}
