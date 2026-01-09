{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

{
  options.extraRules.keychronUdev.enable = mkEnableOption "Keychron V1 user‑service trigger";
  options.extraRules.keychronQ3Udev.enable = mkEnableOption "Keychron Q3 user‑service trigger";

  config = mkMerge [
    (mkIf config.extraRules.keychronUdev.enable {
      # NOTE:
      # For this to work, the following needs to be run:
      #   sudo loginctl enable-linger {username}
      # Where {username} = user name
      users.extraUsers.pabloagn.linger = true;
      services.udev.extraRules = ''
        ACTION=="add", SUBSYSTEM=="input", KERNEL=="event*", \
          ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0311", \
          TAG+="systemd", \
          ENV{SYSTEMD_USER_WANTS}+="rh-kmonad-keychron.service"
      '';
    })
    (mkIf config.extraRules.keychronQ3Udev.enable {
      # NOTE:
      # For this to work, the following needs to be run:
      #   sudo loginctl enable-linger {username}
      # Where {username} = user name
      users.extraUsers.pabloagn.linger = true;
      services.udev.extraRules = ''
        ACTION=="add", SUBSYSTEM=="input", KERNEL=="event*", \
          ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0121", \
          TAG+="systemd", \
          ENV{SYSTEMD_USER_WANTS}+="rh-kmonad-keychron-q3.service"
      '';
    })
  ];
}
