# modules/core/hardware/extra.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.system.hardware.extra;
in
{
  options.rhodium.system.hardware.extra = {
    enableAsusKeyboardBacklightFix = mkOption {
      type = types.bool;
      default = false;
      description = "Enable ASUS N-Key keyboard backlight WMI fix (e.g., for some ROG laptops).";
    };

    configureLogindLidSwitch = mkOption {
      type = types.bool;
      default = true;
      description = "Configure logind lid switch behavior (suspend on lid close, ignore when docked).";
    };
  };

  config = {
    # Keyboard backlight fix
    systemd.services.fix-keyboard-backlight = mkIf cfg.enableAsusKeyboardBacklightFix {
      description = "Execute ASUS keyboard backlight WMI fix on boot";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = ''
          ${pkgs.bash}/bin/bash -c 'echo 0x5002f | tee /sys/kernel/debug/asus-nb-wmi/dev_id && echo 0 | tee /sys/kernel/debug/asus-nb-wmi/ctrl_param && echo 1 | tee /sys/kernel/debug/asus-nb-wmi/ctrl_param && cat /sys/kernel/debug/asus-nb-wmi/devs'
        '';
        User = "root";
      };
    };

    services.logind = mkIf cfg.configureLogindLidSwitch {
      extraConfig = ''
        HandleLidSwitch=suspend
        HandleLidSwitchExternalPower=suspend
        HandleLidSwitchDocked=ignore
      '';
    };
  };
}
