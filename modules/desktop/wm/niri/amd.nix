{pkgs, ...}: {
  imports = [
    ./base.nix
  ];

  environment.systemPackages = with pkgs; [
    radeontop
  ];

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1"; # For invisible cursors
    ELECTRON_OZONE_PLATFORM_HINT = "auto"; # Electron app flickering fix
    AMD_VULKAN_ICD = "RADV";
  };

  # OpenGL options
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      amdvlk
      rocmPackages.clr
      libvdpau-va-gl
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      amdvlk
    ];
  };
}
