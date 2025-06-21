{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.rh-waybar;
in {
  options.services.rh-waybar = {
    enable = mkEnableOption "Highly customizable Wayland bar";
  };

  config = mkIf cfg.enable {
    systemd.user.services.rh-waybar = {
      Unit = {
        Description = "Highly customizable Wayland bar";
        PartOf = ["graphical-session.target"];
        After = ["graphical-session-pre.target"];
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.waybar}/bin/waybar";
        Restart = "on-failure";
        RestartSec = 1;
      };

      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
