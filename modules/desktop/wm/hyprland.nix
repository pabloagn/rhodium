# modules/desktop/wm/hyprland/default.nix

{ lib, config, pkgs, ... }:
let
  cfg = config.rhodium.system.desktop.wm.hyprland;
in
{
  options.rhodium.system.desktop.wm.hyprland = {
    enable = lib.mkEnableOption "Rhodium's Hyprland configuration (system)";
    amdSpecificSetup = lib.mkEnableOption "AMD specific GPU setup for Hyprland";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      xwayland.enable = true;
    };

    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      default = "hyprland";
    };

    environment.systemPackages = lib.mkIf cfg.amdSpecificSetup (
      with pkgs; [radeontop ]
    );

    environment.sessionVariables = lib.mkIf cfg.amdSpecificSetup {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
      AMD_VULKAN_ICD = "RADV";
    };

    hardware.graphics = lib.mkIf cfg.amdSpecificSetup {
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

    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
    ];
  };
}
