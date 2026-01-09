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
    justineConfigFile = mkOption {
      type = types.path;
      default = config.home.homeDirectory + "/.config/kmonad/justine.kbd";
    };
    alexandriaConfigFile = mkOption {
      type = types.path;
      default = config.home.homeDirectory + "/.config/kmonad/alexandria.kbd";
    };
    keychronQ3ConfigFile = mkOption {
      type = types.path;
      default = config.home.homeDirectory + "/.config/kmonad/keychron-q3.kbd";
    };
    extraArgs = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };
  config = mkIf cfg.enable {
    systemd.user.services.rh-kmonad-alexandria = {
      Unit.PartOf = [ "graphical-session.target" ];
      Unit.Wants = [ "dbus-org.freedesktop.Notifications.service" ];
      Unit.After = [
        "graphical-session-pre.target"
        "dbus-org.freedesktop.Notifications.service"
      ];
      Unit.ConditionPathExists = "/dev/input/event4";
      Service.Type = "simple";
      Service.ExecStart =
        "${pkgs.kmonad}/bin/kmonad ${cfg.alexandriaConfigFile} " + (lib.concatStringsSep " " cfg.extraArgs);
      Service.Restart = "on-failure";
      Service.RestartSec = 1;
      Service.Nice = -5;
      Install.WantedBy = [ "graphical-session.target" ];
    };

    systemd.user.services.rh-kmonad-justine = {
      Unit = {
        PartOf = [ "graphical-session.target" ];
        Wants = [ "dbus-org.freedesktop.Notifications.service" ];
        After = [ "graphical-session.target" ];
        # After = [
        #   "graphical-session-pre.target"
        #   "dbus-org.freedesktop.Notifications.service"
        # ];
        ConditionPathExists = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
      };
      Service = {
        Type = "simple";
        ExecStart =
          "${pkgs.kmonad}/bin/kmonad ${cfg.justineConfigFile} " + (lib.concatStringsSep " " cfg.extraArgs);
        Restart = "on-failure";
        RestartSec = 1;
        Nice = -5;
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    systemd.user.services.rh-kmonad-keychron = {
      Unit = {
        Description = "KMonad – Keychron V1";
        # Make sure it isn't started unless the device is really there
        ConditionPathExists = "/dev/input/by-id/usb-Keychron_Keychron_V1-event-kbd";
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.kmonad}/bin/kmonad ${cfg.configFile} " + lib.concatStringsSep " " cfg.extraArgs;
        Restart = "on-failure";
        Nice = -5;
      };
    };

    systemd.user.services.rh-kmonad-keychron-q3 = {
      Unit = {
        Description = "KMonad – Keychron Q3";
        ConditionPathExists = "/dev/input/by-id/usb-Keychron_Keychron_Q3-if02-event-kbd";
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.kmonad}/bin/kmonad ${cfg.keychronQ3ConfigFile} " + lib.concatStringsSep " " cfg.extraArgs;
        Restart = "on-failure";
        Nice = -5;
      };
    };
  };
}
