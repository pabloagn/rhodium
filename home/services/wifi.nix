{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.userExtraServices.rh-wifiSwitch;
in
{
  options.userExtraServices.rh-wifiSwitch.enable = mkEnableOption "WiFi auto-switch user service for NETGEAR A8000";

  config = mkIf cfg.enable {
    systemd.user.services.rh-wifi-switch = {
      Unit = {
        Description = "WiFi adapter auto-switch (NETGEAR A8000)";
        After = [ "network.target" ];
      };

      Service = {
        Type = "oneshot";
        ExecStart = "%h/.local/bin/utils/utils-switch-wifi.sh";
        # Ensure nmcli is available
        Environment = [
          "PATH=${pkgs.networkmanager}/bin:${pkgs.coreutils}/bin:${pkgs.util-linux}/bin"
        ];
      };
    };
  };
}
