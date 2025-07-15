{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.userExtraServices.rh-kmonad;
  makeService = configFile: devicePath: {
    Unit.PartOf = [ "graphical-session.target" ];
    Unit.Wants = [ "dbus-org.freedesktop.Notifications.service" ];
    Unit.After = [
      "graphical-session-pre.target"
      "dbus-org.freedesktop.Notifications.service"
    ];
    Unit.ConditionPathExists = devicePath;
    Service.Type = "simple";
    Service.ExecStartPre = "${pkgs.coreutils}/bin/sleep 2";
    Service.ExecStart =
      "${pkgs.kmonad}/bin/kmonad ${configFile} " + (lib.concatStringsSep " " cfg.extraArgs);
    Service.Restart = "on-failure";
    Service.RestartSec = 1;
    Service.Nice = -5;
    Install.WantedBy = [ "default.target" ];
  };
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
    systemd.user.services.rh-kmonad-justine =
      (makeService cfg.internalConfigFile "/dev/input/by-path/platform-i8042-serio-0-event-kbd")
      // {
        Install.WantedBy = [ "graphical-session.target" ];
      };
    systemd.user.services.rh-kmonad-keychron = makeService cfg.configFile "/dev/input/by-id/usb-Keychron_Keychron_V1-event-kbd";
  };
}
