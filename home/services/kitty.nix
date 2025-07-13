{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.userExtraServices.rh-kitty-daemon;
in
{
  options.userExtraServices.rh-kitty-daemon = {
    enable = mkEnableOption "Kitty terminal daemon for instant startup";
  };
  config = mkIf cfg.enable {
    systemd.user.services.rh-kitty-daemon = {
      Unit = {
        Description = "Kitty terminal daemon";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session-pre.target" ];
      };
      Service = {
        Type = "forking";
        ExecStart = "${pkgs.kitty}/bin/kitty --single-instance --detach --hold";
        ExecStop = "${pkgs.kitty}/bin/kitty @ close-window --match id:1";
        Restart = "on-failure";
        RestartSec = 5;
        Environment = [
          "WAYLAND_DISPLAY=wayland-1"
        ];
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
    # Alias for opening new windows
    home.shellAliases.kitty = "${pkgs.kitty}/bin/kitty @ launch --type=os-window --cwd=current";
  };
}
