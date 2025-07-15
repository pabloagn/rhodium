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
      description = "Config file for the external Keychron keyboard";
    };

    internalConfigFile = mkOption {
      type = types.path;
      description = "Config file for the internal keyboard";
    };

    extraArgs = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };

  config = mkIf cfg.enable {
    systemd.services.rh-kmonad-keychron = {
      description = "KMonad for external Keychron keyboard";
      wantedBy = [ "dev-input-keychron_v1.device" ];
      bindsTo = [ "dev-input-keychron_v1.device" ];
      after = [ "dev-input-keychron_v1.device" ];
      unitConfig.ConditionPathExists = "/dev/input/keychron_v1";
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

