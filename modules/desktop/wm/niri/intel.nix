{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./base.nix
  ];

  # Add these kernel modules
  boot.kernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
    "kvm-intel"
  ];

  # NVIDIA drivers package (use the stable version)
  hardware.nvidia = {
    open = true; # Use open kernel modules for Turing or later GPUs (RTX series)
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement.enable = true; # Enable power management (suspend/resume)
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct"; # For hardware video acceleration
    ELECTRON_OZONE_PLATFORM_HINT = "auto"; # Electron app flickering fix
    NIXOS_OZONE_WL = "1"; # Auto configure Electron apps for Wayland
  };

  # Required NVIDIA utilities and EGL support
  environment.systemPackages = with pkgs; [
    egl-wayland
    nvidia-vaapi-driver
    libvdpau-va-gl
  ];

  # Enable NVIDIA settings
  services.xserver.videoDrivers = [ "nvidia" ];

  # Enable Wayland compatibility with Electron
  #services.xserver.displayManager.wayland.enable = true;
}
