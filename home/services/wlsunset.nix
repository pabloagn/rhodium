{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.userExtraServices.rh-wlsunset;
in
{
  options.userExtraServices.rh-wlsunset = {
    enable = mkEnableOption "Gamma correction for wayland supporting wlr-gamma-control-unstable-v1";
  };

  config = mkIf cfg.enable {
    systemd.user.services.rh-wlsunset = {
      Unit = {
        Description = "Gamma correction for wayland supporting wlr-gamma-control-unstable-v1";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session-pre.target" ];
        ConditionEnvironment = "WAYLAND_DISPLAY";
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.wlsunset}/bin/wlsunset -l 51.4 -L -0.12"; # Coordinates go here
        Restart = "on-failure";
        RestartSec = 5;
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
