{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.userExtraServices.rh-kmonad;
  makeKmonadService = configFile: {
    Unit = {
      Description = "KMonad";
      PartOf = [ "graphical-session.target" ];
      Wants = [ "dbus-org.freedesktop.Notifications.service" ];
      After = [
        "graphical-session-pre.target"
        "dbus-org.freedesktop.Notifications.service"
      ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.kmonad}/bin/kmonad ${configFile} " + (lib.concatStringsSep " " cfg.extraArgs);
      Restart = "on-failure";
      RestartSec = 1;
      Nice = -5;
    };
    Install = {
      WantedBy = [ ];
    };
  };
in
{
  # Always‑on built‑in keyboard
  systemd.user.services.rh-kmonad-justine = (makeKmonadService cfg.internalConfigFile) // {
    Unit.Description = "KMonad – Built‑in Keyboard (justine)";
    Install.WantedBy = [ "graphical-session.target" ];
  };

  # Hot‑plug‑driven external keyboard
  systemd.user.services.rh-kmonad-keychron = (makeKmonadService cfg.configFile) // {
    Unit.Description = "KMonad – External Keyboard (Keychron V1)";
    Unit.ConditionPathExists = "/dev/input/by-id/usb-Keychron_Keychron_V1-event-kbd";
    Unit.After = [ "dev-input-keychron_v1.device" ];
    Unit.BindsTo = [ "dev-input-keychron_v1.device" ];
    Install.WantedBy = [ "dev-input-keychron_v1.device" ];
  };
}
