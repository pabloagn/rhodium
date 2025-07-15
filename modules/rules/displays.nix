{ lib, config, ... }:
with lib;
{
  options.extraRules.hdmiAutoSwitch.enable = mkEnableOption "Udev rule for HDMI auto-switching (disables eDP-1 when HDMI connected)";
  
  config = mkIf config.extraRules.hdmiAutoSwitch.enable {
    services.udev.extraRules = ''
      # HDMI-A-1 connected
      ACTION=="change", SUBSYSTEM=="drm", KERNEL=="card[0-9]*", \
        ENV{DISPLAY_STATUS}=="connected", \
        ENV{DEVPATH}=="*/drm/card*/card*-HDMI-A-1", \
        TAG+="systemd", \
        ENV{SYSTEMD_USER_WANTS}="rh-hdmi-switch-connected.service"

      # HDMI-A-2 connected
      ACTION=="change", SUBSYSTEM=="drm", KERNEL=="card[0-9]*", \
        ENV{DISPLAY_STATUS}=="connected", \
        ENV{DEVPATH}=="*/drm/card*/card*-HDMI-A-2", \
        TAG+="systemd", \
        ENV{SYSTEMD_USER_WANTS}="rh-hdmi-switch-connected.service"

      # HDMI-A-1 disconnected
      ACTION=="change", SUBSYSTEM=="drm", KERNEL=="card[0-9]*", \
        ENV{DISPLAY_STATUS}=="disconnected", \
        ENV{DEVPATH}=="*/drm/card*/card*-HDMI-A-1", \
        TAG+="systemd", \
        ENV{SYSTEMD_USER_WANTS}="rh-hdmi-switch-disconnected.service"

      # HDMI-A-2 disconnected
      ACTION=="change", SUBSYSTEM=="drm", KERNEL=="card[0-9]*", \
        ENV{DISPLAY_STATUS}=="disconnected", \
        ENV{DEVPATH}=="*/drm/card*/card*-HDMI-A-2", \
        TAG+="systemd", \
        ENV{SYSTEMD_USER_WANTS}="rh-hdmi-switch-disconnected.service"
    '';
  };
}
