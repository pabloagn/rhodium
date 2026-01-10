{ pkgs, ... }:
{
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
  # NOTE: RADV (Mesa's Vulkan driver for AMD) is enabled by default.
  # amdvlk was removed from nixpkgs as AMD deprecated it.
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr
      libvdpau-va-gl
    ];
  };
}
