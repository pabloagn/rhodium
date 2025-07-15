{ lib, config, ... }:

with lib;

{
  options.extraRules.keychronUdev.enable = mkEnableOption "Udev rule for Keychron V1 (exposes /dev/input/keychron_v1)";

  config = mkIf config.extraRules.keychronUdev.enable {
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="input", KERNEL=="event*", \
        ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0311", \
        ENV{ID_SEAT}=="seat0", \
        TAG+="uaccess", \
        ENV{SYSTEMD_USER_WANTS}="kmonad.service"
    '';
  };
}
