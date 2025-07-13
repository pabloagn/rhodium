{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.extraServices.asusKeyboardBacklight;
in
{
  options.extraServices.asusKeyboardBacklight = {
    enable = mkEnableOption "ASUS keyboard backlight fix";
  };

  config = mkIf cfg.enable {
    systemd.services.fix-keyboard-backlight = {
      description = "Execute ASUS-specific keyboard backlight fix on boot";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.bash}/bin/bash -c 'echo 0x5002f | tee /sys/kernel/debug/asus-nb-wmi/dev_id && echo 0 | tee /sys/kernel/debug/asus-nb-wmi/ctrl_param && echo 1 | tee /sys/kernel/debug/asus-nb-wmi/ctrl_param && cat /sys/kernel/debug/asus-nb-wmi/devs'";
        User = "root";
        Type = "oneshot";
        RemainAfterExit = true;
      };
    };
  };
}
