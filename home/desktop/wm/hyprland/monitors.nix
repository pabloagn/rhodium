{ ... }:
# TODO:
# - How do we make this dynamic depending on the host?
# - Since this is user-level config
{
  wayland.windowManager.hyprland = {
    extraConfig = ''
      # Monitors
      monitor=eDP-1,2880x1620@120,0x0,1.5
      monitor=eDP-2,1920x1080@300,0x0,1.0
      monitor=HDMI-A-1,3840x2160@60,0x0,1.5
    '';
  };
}
