{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.userExtraServices.rh-wezterm-daemon;
in {
  options.userExtraServices.rh-wezterm-daemon = {
    enable = mkEnableOption "WezTerm terminal daemon for instant startup";
  };
  config = mkIf cfg.enable {
    systemd.user.services.rh-wezterm-daemon = {
      Unit = {
        Description = "WezTerm terminal daemon";
        PartOf = ["graphical-session.target"];
        After = ["graphical-session-pre.target"];
      };
      Service = {
        Type = "exec";
        ExecStart = "${pkgs.wezterm}/bin/wezterm start --no-auto-connect --class wezterm-daemon";
        ExecStop = "${pkgs.wezterm}/bin/wezterm cli kill-server";
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
    # Alias for opening new windows
    home.shellAliases.wezterm = "${pkgs.wezterm}/bin/wezterm cli spawn --new-window";
  };
}
