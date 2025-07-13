{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.extraServices.laptopLid;
in
{
  options.extraServices.laptopLid = {
    enable = mkEnableOption "Custom laptop lid handling";

    handleLidSwitch = mkOption {
      type = types.enum [
        "suspend"
        "hibernate"
        "poweroff"
        "lock"
        "ignore"
      ];
      default = "suspend";
      description = "Action when laptop lid is closed";
    };

    handleLidSwitchExternalPower = mkOption {
      type = types.enum [
        "suspend"
        "hibernate"
        "poweroff"
        "lock"
        "ignore"
      ];
      default = "suspend";
      description = "Action when laptop lid is closed on external power";
    };

    handleLidSwitchDocked = mkOption {
      type = types.enum [
        "suspend"
        "hibernate"
        "poweroff"
        "lock"
        "ignore"
      ];
      default = "ignore";
      description = "Action when laptop lid is closed while docked";
    };
  };

  config = mkIf cfg.enable {
    services.logind = {
      extraConfig = ''
        HandleLidSwitch=${cfg.handleLidSwitch}
        HandleLidSwitchExternalPower=${cfg.handleLidSwitchExternalPower}
        HandleLidSwitchDocked=${cfg.handleLidSwitchDocked}
      '';
    };
  };
}
