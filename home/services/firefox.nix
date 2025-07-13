{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.userExtraServices.rh-firefox-preload;
in
{
  options.userExtraServices.rh-firefox-preload = {
    enable = mkEnableOption "Firefox preloader for faster startup";
  };
  config = mkIf cfg.enable {
    systemd.user.services.rh-firefox-preload = {
      Unit = {
        Description = "Firefox preloader";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session-pre.target" ];
      };
      Service = {
        Type = "exec";
        # Start minimized with a blank page
        ExecStart = "${pkgs.firefox}/bin/firefox --headless --width 1 --height 1 about:blank";
        ExecStop = "${pkgs.procps}/bin/pkill firefox";
        Restart = "on-failure";
        RestartSec = 10;
        # Higher memory limit for Firefox
        MemoryLimit = "2G";
        Environment = [
          "MOZ_ENABLE_WAYLAND=1"
          "WAYLAND_DISPLAY=wayland-1"
        ];
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
