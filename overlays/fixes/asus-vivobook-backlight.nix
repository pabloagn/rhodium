/*
* Route: /clients/native/system/boot/services.nix
* Type: Module
* Created by: Pablo Aguirre
*/

{ config, pkgs, ... }:

{
  # ASUS VivoBook keyboard backlight fix
  systemd.services.fix-keyboard-backlight = {
    description = "Execute ASUS-specific keyboard backlight fix on boot";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo 0x5002f | tee /sys/kernel/debug/asus-nb-wmi/dev_id && echo 0 | tee /sys/kernel/debug/asus-nb-wmi/ctrl_param && echo 1 | tee /sys/kernel/debug/asus-nb-wmi/ctrl_param && cat /sys/kernel/debug/asus-nb-wmi/devs'";
      User = "root";
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };

  systemd.services.fix-keyboard-backlight.enable = true;

  # Gnome Keyring required by Proton Bridge
  services.gnome.gnome-keyring.enable = true;
}
