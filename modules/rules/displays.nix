{ lib, config, ... }:
with lib;
{
  options.extraRules.hdmiAutoSwitch.enable = mkEnableOption "Udev rule for HDMI auto-switching (disables eDP-1 when HDMI connected)";
  
  config = mkIf config.extraRules.hdmiAutoSwitch.enable {
    services.udev.extraRules = ''
      # HDMI-A-1 connected
      SUBSYSTEM=="drm", ACTION=="change", ENV{HOTPLUG}=="1", \
        DEVPATH=="*/drm/card*/card*-HDMI-A-1", \
        ATTR{status}=="connected", \
        TAG+="systemd", \
        ENV{SYSTEMD_USER_WANTS}="rh-hdmi-switch-connected.service"

      # HDMI-A-2 connected
      SUBSYSTEM=="drm", ACTION=="change", ENV{HOTPLUG}=="1", \
        DEVPATH=="*/drm/card*/card*-HDMI-A-2", \
        ATTR{status}=="connected", \
        TAG+="systemd", \
        ENV{SYSTEMD_USER_WANTS}="rh-hdmi-switch-connected.service"

      # HDMI-A-1 disconnected
      SUBSYSTEM=="drm", ACTION=="change", ENV{HOTPLUG}=="1", \
        DEVPATH=="*/drm/card*/card*-HDMI-A-1", \
        ATTR{status}=="disconnected", \
        TAG+="systemd", \
        ENV{SYSTEMD_USER_WANTS}="rh-hdmi-switch-disconnected.service"

      # HDMI-A-2 disconnected
      SUBSYSTEM=="drm", ACTION=="change", ENV{HOTPLUG}=="1", \
        DEVPATH=="*/drm/card*/card*-HDMI-A-2", \
        ATTR{status}=="disconnected", \
        TAG+="systemd", \
        ENV{SYSTEMD_USER_WANTS}="rh-hdmi-switch-disconnected.service"
    '';
  };
}
