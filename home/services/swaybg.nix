{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.userExtraServices.rh-swaybg;
  targetDir = "/var/tmp/current-wallpaper";
in
{
  options.userExtraServices.rh-swaybg = {
    enable = mkEnableOption "Wallpaper tool for Wayland compositors";
  };

  config = mkIf cfg.enable {
    systemd.user.services.rh-swaybg = {
      Unit = {
        Description = "Wallpaper daemon for Wayland";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session-pre.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.swaybg}/bin/swaybg -m fill -i ${targetDir}";
        Restart = "on-failure";
        RestartSec = 1;
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
