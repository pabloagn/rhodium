{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

{
  # NOTE:
  # For this to work, the following needs to be run:
  #   sudo loginctl enable-linger {username}
  # Where {username} = user name
  # options.extraRules.keychronUdev.enable = mkEnableOption "Udev rule for Keychron V1";
  # config = mkIf config.extraRules.keychronUdev.enable {
  #   services.udev.extraRules = ''
  #     ACTION=="add", SUBSYSTEM=="input", KERNEL=="event*", \
  #       ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0311", \
  #       ENV{ID_SEAT}=="seat0", \
  #       TAG+="uaccess", \
  #       ENV{SYSTEMD_USER_WANTS}="rh-kmonad-keychron.service"
  #
  #     ACTION=="remove", SUBSYSTEM=="input", KERNEL=="event*", \
  #       ENV{ID_VENDOR_ID}=="3434", ENV{ID_MODEL_ID}=="0311", \
  #       RUN+="${pkgs.systemd}/bin/systemctl --user stop rh-kmonad-keychron.service"
  #   '';
  # };
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="input", KERNEL=="event*", \
      ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0311", \
      TAG+="systemd", ENV{SYSTEMD_WANTS}="kmonad-keychron.service"

    ACTION=="remove", SUBSYSTEM=="input", KERNEL=="event*", \
      ENV{ID_VENDOR_ID}=="3434", ENV{ID_MODEL_ID}=="0311", \
      RUN+="${pkgs.systemd}/bin/systemctl stop kmonad-keychron.service"
  '';

}
