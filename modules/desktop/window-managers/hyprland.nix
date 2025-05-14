# modules/desktop/window-managers/hyprland.nix

{ lib, config, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.desktop.windowManager == "hyprland" && config.mySystem.hostProfile == "gui-desktop") {
    programs.hyprland = {
      enable = true;
      package = if config.mySystem.hardware.amdGpu then pkgs.hyprland-amd else pkgs.hyprland; # Example
      # nvidiaPatches = lib.mkIf config.mySystem.hardware.nvidiaGpu true; # If using NVIDIA

      # Default Hyprland portal (good for screen sharing, etc.)
      xdg.portal.enable = true;
      xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    };

    # Enable Wayland session management
    programs.wayland.enable = true; # May not be needed if Hyprland package handles it

    # Basic environment for Hyprland
    environment.systemPackages = with pkgs; [
      wayland # Core Wayland protocols
      libva # VA-API for hardware video acceleration
      # Add mesa if not pulled in by GPU drivers for amdGpu
    ];

    # AMD GPU specific settings
    services.xserver.videoDrivers = lib.mkIf config.mySystem.hardware.amdGpu [ "amdgpu" ];
    boot.kernelModules = lib.mkIf config.mySystem.hardware.amdGpu [ "amdgpu" ];
    # Add other AMD specific settings here if needed (firmware, etc.)

    # Theming for Hyprland (borders, gaps, some colors) will be applied by modules/themes/apply.nix
    # Specific keybinds, window rules etc., would go into user's Home Manager config for Hyprland.
    # Or, you can provide system-wide defaults here that users can override.
    # Example for system-wide default (HM can override):
    # environment.etc."hypr/hyprland.conf".text = ''
    #   # Basic Hyprland settings from NixOS module
    #   # Colors and fonts will be set by the theme system.
    #   monitor=,preferred,auto,1
    #   exec-once = waybar # If waybar is the chosen bar
    # '';
  };
}
