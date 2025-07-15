{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.userExtraServices.rh-kmonad;

  makeService = configFile: {
    Unit.PartOf = [ "graphical-session.target" ];
    Unit.Wants = [ "dbus-org.freedesktop.Notifications.service" ];
    Unit.After = [
      "graphical-session-pre.target"
      "dbus-org.freedesktop.Notifications.service"
    ];

    # Ensure device exists before starting
    Unit.ConditionPathExists = "/dev/input/by-id/usb-Keychron_Keychron_V1-event-kbd";

    Service.Type = "simple";
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
    systemd.user.services.rh-kmonad-justine = (makeService cfg.internalConfigFile) // {
      Install.WantedBy = [ "graphical-session.target" ];
    };

    systemd.user.services.rh-kmonad-keychron = makeService cfg.configFile;
  };
}
