{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.userExtraServices.rh-eww;
in
{
  options.userExtraServices.rh-eww = {
    enable = mkEnableOption "Highly customizable widgets";
  };

  config = mkIf cfg.enable {
    systemd.user.services.rh-eww = {
      Unit = {
        Description = "ElKowar's Wacky Widgets";
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        Environment = [
          "PATH=${config.home.profileDirectory}/bin:/run/current-system/sw/bin"
        ];

        # --- Main Service ---
        ExecStart = "${config.programs.eww.package}/bin/eww daemon --no-daemonize";

        # --- Eww Widgets ---
        ExecStartPost = [
          "${config.programs.eww.package}/bin/eww open bar"
          # "${config.programs.eww.package}/bin/eww open widgets"
        ];

        # --- Stop Eww ---
        ExecStop = "${config.programs.eww.package}/bin/eww kill";
        Restart = "on-failure";
        RestartSec = "5";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
