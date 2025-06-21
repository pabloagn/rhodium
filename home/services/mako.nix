{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.mako;
in {
  options.services.mako = {
    enable = mkEnableOption "A lightweight Wayland notification daemon";
  };

  config = mkIf cfg.enable {
    systemd.user.services.mako = {
      Unit = {
        Description = "Mako notification daemon";
        PartOf = ["graphical-session.target"];
        After = ["graphical-session-pre.target"];
      };

      Service = {
        Type = "dbus";
        BusName = "org.freedesktop.Notifications";
        ExecStart = "${pkgs.mako}/bin/mako";
        Restart = "on-failure";
        RestartSec = 1;
      };

      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
