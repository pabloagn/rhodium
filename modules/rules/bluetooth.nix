{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
{
  options.extraRules.bluetoothNoPowerSave.enable = mkEnableOption "Disable USB autosuspend for Bluetooth adapter";

  config = mkIf config.extraRules.bluetoothNoPowerSave.enable {
    services.udev.extraRules = ''
      # Disable USB autosuspend for Foxconn Bluetooth adapter (0489:e0f5)
      # Prevents connection delay when reconnecting Bluetooth devices
      ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0489", ATTR{idProduct}=="e0f5", \
        ATTR{power/control}="on"
    '';
  };
}
