{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    brightnessctl # Read & control device brightness
    ddcutil # Gamma & temperature set fallback for hardware control
    gammastep # Gamma & temperature set for wayland
    geoclue2 # Geolocation framework for gammastep
    wdisplays # GUI for exploring and setting monitor options
    wlsunset # Gamma & temperature set for wayland supporting wlr-gamma-control-unstable-v1
  ];
}
