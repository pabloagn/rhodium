{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.swaybg;
in {
  options.services.swaybg = {
    enable = mkEnableOption "Wallpaper tool for Wayland compositors";
  };

  config = mkIf cfg.enable {
    systemd.user.services.swaybg = {
      Unit = {
        Description = "Wallpaper daemon for Wayland";
        PartOf = ["graphical-session.target"];
        After = ["graphical-session-pre.target"];
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.swaybg}/bin/swaybg -m fill -i ${config.xdg.dataHome}/wallpapers/dante/wallpaper-01.jpg";
        Restart = "on-failure";
        RestartSec = 1;
      };

      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
