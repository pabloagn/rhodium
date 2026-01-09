{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
{
  options.extraRules.netgearA8000Udev.enable = mkEnableOption "NETGEAR A8000 WiFi adapter udev rules for automatic switching";

  config = mkIf config.extraRules.netgearA8000Udev.enable {
    # Ensure user lingering is enabled so systemd user services can run
    users.extraUsers.pabloagn.linger = true;

    # udev rules for NETGEAR A8000 (USB ID: 0846:9060, mt7921u driver)
    # Triggers on both add and remove events
    services.udev.extraRules = ''
      # NETGEAR A8000 WiFi Adapter - Plug in (switch to external adapter)
      ACTION=="add", SUBSYSTEM=="net", KERNEL=="wlp*", \
        ATTRS{idVendor}=="0846", ATTRS{idProduct}=="9060", \
        TAG+="systemd", \
        ENV{SYSTEMD_USER_WANTS}+="rh-wifi-switch.service"

      # NETGEAR A8000 WiFi Adapter - Unplug (revert to internal adapter)
      ACTION=="remove", SUBSYSTEM=="usb", ENV{ID_VENDOR_ID}=="0846", ENV{ID_MODEL_ID}=="9060", \
        RUN+="${pkgs.util-linux}/bin/runuser -u pabloagn -- ${pkgs.systemd}/bin/systemctl --user start --no-block rh-wifi-switch.service"
    '';
  };
}
