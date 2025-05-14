# modules/desktop/default.nix

{ lib, config, pkgs, ... }: {

  imports = [
    ./window-managers/hyprland.nix
    ./services/dunst.nix
    ./components/launchers/rofi.nix
    ./applications/terminal/ghostty.nix
    ./peripherals/default.nix
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    font-awesome
  ];

  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  # Enable D-Bus daemon
  services.dbus.enable = true;

  # Common desktop packages you want available system-wide
  environment.systemPackages = with pkgs; [
  ];
}
