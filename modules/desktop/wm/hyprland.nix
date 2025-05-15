# modules/desktop/wm/hyprland/default.nix

{ lib, config, pkgs, ... }:

{
  # Hyprland Program Enablement
  programs.hyprland = {
    enable = true; # Enable Hyprland system-wide
    package = pkgs.hyprland; # Can be overridden by overlays if needed
    xwayland.enable = true; # For X11 app compatibility
  };

  # Display Manager
  services.xserver = {
    enable = true; # Needed for GDM and XWayland
    displayManager.gdm.enable = true;
    # TODO: displayManager.gdm.wayland = true; # Optional: Make GDM default to Wayland
  };
  # programs.hyprland.enable usually takes care of xdg-desktop-portal-hyprland.
  # We ensure the main portal service is on and add GTK as a common fallback.
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    # If programs.hyprland doesn't set it as default, or we want to be explicit
    default = "hyprland";
  };

  # AMD GPU Specific System Setup
  environment.systemPackages = lib.mkIf true (with pkgs; [
    # TODO: Replace 'true' with your AMD GPU condition
    radeontop
    # hypridle
  ]);

  environment.sessionVariables = lib.mkIf true {
    # TODO: Replace 'true' with your AMD GPU condition
    # For invisible cursors on some AMD setups
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
    # AMD-specific environment variables
    # NOTE: New addition for screen artifact debugging
    AMD_VULKAN_ICD = "RADV";
  };

  # OpenGL/Graphics options for AMD
  hardware.graphics = lib.mkIf true { # TODO: Replace 'true' with your AMD GPU condition
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      amdvlk
      rocmPackages.clr
      # NOTE: New addition for screen artifact debugging
      libvdpau-va-gl
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      amdvlk
    ];
  };

  # Basic font set
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    font-awesome
  ];
}
