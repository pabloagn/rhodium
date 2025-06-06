{ config, pkgs, ... }:

{
  imports = [
    ./base.nix
  ];
  
  environment.systemPackages = with pkgs; [
    egl-wayland  # Required for EGL-Wayland compatibility
    libva-nvidia-driver  # nvidia-vaapi-driver equivalent for hardware video acceleration
  ];
  
  environment.sessionVariables = {
    # Required NVIDIA environment variables per Hyprland docs
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    
    # Hardware video acceleration
    NVD_BACKEND = "direct"; # For nvidia-vaapi-driver
    
    # Electron/CEF app support
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    
    WLR_NO_HARDWARE_CURSORS = "1"; # May still be needed for some setups
  };
  
  # Enable NVIDIA drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  
  hardware.nvidia = {
    # Modesetting is required for Wayland
    modesetting.enable = true;
    
    # Power management for suspend/resume
    powerManagement.enable = true;
    
    # Use open source kernel modules for newer GPUs (RTX 16xx/20xx+)
    # Set to false for older cards or if you have issues
    open = false; # Change to true for newer GPUs if supported
    
    # Enable NVIDIA settings
    nvidiaSettings = true;
    
    # Use stable driver version
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  
  # Graphics/OpenGL configuration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver # Hardware video acceleration
      libvdpau-va-gl
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      nvidia-vaapi-driver
    ];
  };
}
