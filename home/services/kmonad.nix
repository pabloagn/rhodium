{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.userExtraServices.rh-kmonad;
in
{
  options.userExtraServices.rh-kmonad = {
    enable = mkEnableOption "KMonad user services";
    configFile = mkOption {
      type = types.path;
      default = config.home.homeDirectory + "/.config/kmonad/keychron.kbd";
    };
    internalConfigFile = mkOption {
      type = types.path;
      default = config.home.homeDirectory + "/.config/kmonad/justine.kbd";
    };
    extraArgs = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };
  config = mkIf cfg.enable {
    systemd.user.services.rh-kmonad-justine = {
      Unit.PartOf = [ "graphical-session.target" ];
      Unit.Wants = [ "dbus-org.freedesktop.Notifications.service" ];
      Unit.After = [
        "graphical-session-pre.target"
        "dbus-org.freedesktop.Notifications.service"
      ];
      Unit.ConditionPathExists = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
      Service.Type = "simple";
      Service.ExecStart =
        "${pkgs.kmonad}/bin/kmonad ${cfg.internalConfigFile} " + (lib.concatStringsSep " " cfg.extraArgs);
      Service.Restart = "on-failure";
      Service.RestartSec = 1;
      Service.Nice = -5;
      Install.WantedBy = [ "graphical-session.target" ];
    };

    systemd.user.services.rh-kmonad-keychron = {
      Unit.PartOf = [ "graphical-session.target" ];
      Unit.Wants = [ "dbus-org.freedesktop.Notifications.service" ];
      Unit.After = [
        "graphical-session-pre.target"
        "dbus-org.freedesktop.Notifications.service"
      ];
      Service.Type = "simple";
      Service.ExecStartPre = "${pkgs.bash}/bin/bash -c 'until [ -e /dev/input/by-id/usb-Keychron_Keychron_V1-event-kbd ]; do sleep 0.5; done'";
      Service.ExecStart =
        "${pkgs.kmonad}/bin/kmonad ${cfg.configFile} " + (lib.concatStringsSep " " cfg.extraArgs);
      Service.Restart = "no";
      Service.Nice = -5;
    };
  };
}
