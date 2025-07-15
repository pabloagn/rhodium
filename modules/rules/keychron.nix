{ lib, config, ... }:

with lib;

{
  # NOTE:
  # For this to work, the following needs to be run:
  #   sudo loginctl enable-linger {username}
  # Where {username} = user name
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
