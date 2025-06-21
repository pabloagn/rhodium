{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.waybar;
in {
  options.services.waybar = {
    enable = mkEnableOption "Highly customizable Wayland bar";
  };

  config = mkIf cfg.enable {
    systemd.user.services.waybar = {
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
