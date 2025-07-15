{ lib, config, ... }:

with lib;

{
  options.extraRules.keychronUdev.enable = mkEnableOption "Udev rule for Keychron V1 (exposes /dev/input/keychron_v1)";

  config = mkIf config.extraRules.keychronUdev.enable {
    services.udev.extraRules = ''
      # Keychron V1 – create /dev/input/keychron_v1 and generate a systemd device unit
      SUBSYSTEM=="input", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0311", \
        SYMLINK+="input/keychron_v1", TAG+="systemd"
    '';
  };
}
