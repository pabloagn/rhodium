{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.extraServices.rh-kmonad;
in
{
  options.extraServices.rh-kmonad = {
    enable = mkEnableOption "KMonad system services";

    keychronConfigFile = mkOption {
      type = types.path;
      description = "KMonad config file for external Keychron keyboard";
    };

    internalConfigFile = mkOption {
      type = types.path;
      description = "KMonad config file for internal keyboard";
    };

    extraArgs = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };

  config = mkIf cfg.enable {
    systemd.services.rh-kmonad-keychron = {
      description = "KMonad for external Keychron keyboard";
      wantedBy = [ "dev-input-by\\x2did-usb\\x2dKeychron_Keychron_V1\\x2devent\\x2dkbd.device" ];
      bindsTo = [ "dev-input-by\\x2did-usb\\x2dKeychron_Keychron_V1\\x2devent\\x2dkbd.device" ];
      after = [ "dev-input-by\\x2did-usb\\x2dKeychron_Keychron_V1\\x2devent\\x2dkbd.device" ];
      unitConfig.ConditionPathExists = "/dev/input/by-id/usb-Keychron_Keychron_V1-event-kbd";
      serviceConfig = {
        ExecStart = "${pkgs.kmonad}/bin/kmonad ${toString cfg.keychronConfigFile} ${lib.concatStringsSep " " cfg.extraArgs}";
        Restart = "on-failure";
        RestartSec = 1;
        Nice = -5;
        Type = "simple";
      };
    };

    systemd.services.rh-kmonad-justine = {
      description = "KMonad for internal keyboard";
      wantedBy = [ "multi-user.target" ];
      after = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.kmonad}/bin/kmonad ${toString cfg.internalConfigFile} ${lib.concatStringsSep " " cfg.extraArgs}";
        Restart = "on-failure";
        RestartSec = 1;
        Nice = -5;
        Type = "simple";
      };
    };
  };
}

