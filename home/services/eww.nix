{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.eww;
in {
  options.services.eww = {
    enable = mkEnableOption "Highly customizable widgets";
  };

  config = mkIf cfg.enable {
    systemd.user.services.eww = {
      Unit = {
        Description = "ElKowar's Wacky Widgets";
        PartOf = ["graphical-session.target"];
      };

      Service = {
        Environment = [
          "PATH=${config.home.profileDirectory}/bin:/run/current-system/sw/bin"
        ];
        ExecStart = "${config.programs.eww.package}/bin/eww daemon --no-daemonize";
        ExecStop = "${config.programs.eww.package}/bin/eww kill";
        Restart = "on-failure";
        RestartSec = "5";
      };

      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
