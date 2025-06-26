{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.userExtraServices.rh-ghostty-daemon;
in {
  options.userExtraServices.rh-ghostty-daemon = {
    enable = mkEnableOption "Ghostty terminal emulator daemon for instant startup";
  };
  config = mkIf cfg.enable {
    systemd.user.services.rh-ghostty-daemon = {
      Unit = {
        Description = "Ghostty terminal daemon";
        PartOf = ["graphical-session.target"];
        After = ["graphical-session-pre.target"];
      };
      Service = {
        Type = "exec";
        ExecStart = "${pkgs.ghostty}/bin/ghostty --gtk-single-instance=true --class=ghostty-daemon";
        Restart = "on-failure";
        RestartSec = 5;
        Environment = [
          "WAYLAND_DISPLAY=wayland-1"
        ];
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
