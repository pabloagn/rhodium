{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.userExtraServices.rh-hdmiAutoSwitch;
in
{
  options.userExtraServices.rh-hdmiAutoSwitch.enable = mkEnableOption "HDMI auto-switch user service";

  config = mkIf cfg.enable {
    systemd.user.services.rh-hdmi-hotplug = {
      Unit.Description = "HDMI/eDP auto‑switch";

      Service = {
        Type = "oneshot";
        ExecStart = "%h/.local/bin/utils/utils-switch-displays.sh";
      };
    };
  };
}
