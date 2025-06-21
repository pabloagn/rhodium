{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    brightnessctl # Read & control device brightness
    wdisplays # GUI for exploring and setting monitor options
    wlsunset # Gamma & temperature set for wayland supporting wlr-gamma-control-unstable-v1
    ddcutil # Gamma & temperature set fallback for hardware control
  ];
}
