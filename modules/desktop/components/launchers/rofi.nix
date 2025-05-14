# modules/desktop/components/launchers/rofi.nix

{ config, pkgs, ... }: {
  # Rofi is often configured via Home Manager, but ensure it's available.
  # If you use rofi-wayland:
  environment.systemPackages = [ pkgs.rofi-wayland ];
  # Or just rofi if you handle Wayland/X11 variants in HM
}
