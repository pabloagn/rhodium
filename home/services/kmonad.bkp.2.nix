{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.userExtraServices.rh-kmonad;

  # --- Helper ---
  makeKmonadService = configFile: {
    Unit = {
      Description = "K-Monad";
      PartOf = [ "graphical-session.target" ];
      Wants = [ "dbus-org.freedesktop.Notifications.service" ];
      After = [
        "graphical-session-pre.target"
        "dbus-org.freedesktop.Notifications.service"
      ];
    };
    Service = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.kmonad}/bin/kmonad \
          ${configFile} ${lib.concatStringsSep " " cfg.extraArgs}
      '';
      Restart = "on-failure";
      RestartSec = 1;
      Nice = "-5";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
in
{
  options.userExtraServices.rh-kmonad = {
    enable = mkEnableOption "Keyboard remapping with K-Monad";

    configFile = mkOption {
      type = types.path;
      default = config.home.homeDirectory + "/.config/kmonad/keychron.kbd";
      description = "Absolute path of the *.kbd* file for the external keyboard.";
    };

    internalConfigFile = mkOption {
      type = types.path;
      default = config.home.homeDirectory + "/.config/kmonad/justine.kbd";
      description = "Absolute path of the *.kbd* file for the built-in keyboard.";
    };

    extraArgs = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Additional CLI arguments passed to kmonad.";
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.rh-kmonad-keychron = makeKmonadService cfg.configFile;
    systemd.user.services.rh-kmonad-justine = makeKmonadService cfg.internalConfigFile;
  };
}
