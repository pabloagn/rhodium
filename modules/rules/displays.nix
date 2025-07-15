{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
{
  options.extraRules.hdmiAutoSwitch.enable = mkEnableOption "Udev rule for HDMI auto-switching";

  config = mkIf config.extraRules.hdmiAutoSwitch.enable {
    services.udev.extraRules = ''
      ACTION=="change", SUBSYSTEM=="drm", ENV{HOTPLUG}=="1", \
        DEVPATH=="*/drm/card1", \
        RUN+="${pkgs.util-linux}/bin/runuser -u pabloagn -- ${pkgs.systemd}/bin/systemctl --user start --no-block rh-hdmi-hotplug.service"
    '';
  };
}
