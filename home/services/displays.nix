{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.userExtraServices.rh-hdmiAutoSwitch;
in
{
  options.userExtraServices.rh-hdmiAutoSwitch.enable = mkEnableOption "HDMI auto-switch user service";

  config = mkIf cfg.enable {
    systemd.user.services.rh-hdmi-hotplug = {
      Unit.Description = "HDMI/eDP auto‑switch";

      Service = {
        Type = "oneshot";
        ExecStart = "%h/.local/bin/utils/utils-switch-displays.sh";
      };
    };
  };
}
# with lib;
# let
#   cfg = config.userExtraServices.rh-hdmiAutoSwitch;
#
#   hdmiConnectedScript = pkgs.writeShellScript "hdmi-connected" ''
#     export WAYLAND_DISPLAY=wayland-1
#     ${pkgs.wlr-randr}/bin/wlr-randr --output eDP-1 --off
#   '';
#
#   hdmiDisconnectedScript = pkgs.writeShellScript "hdmi-disconnected" ''
#     export WAYLAND_DISPLAY=wayland-1
#     ${pkgs.wlr-randr}/bin/wlr-randr --output eDP-1 --on
#   '';
# in
# {
#   options.userExtraServices.rh-hdmiAutoSwitch = {
#     enable = mkEnableOption "HDMI auto-switch services";
#   };
#
#   config = mkIf cfg.enable {
#     systemd.user.services.rh-hdmi-switch-connected = {
#       Unit.Description = "Switch displays when HDMI is connected";
#       Unit.PartOf = [ "graphical-session.target" ];
#       Unit.After = [ "graphical-session-pre.target" ];
#       Service.Type = "oneshot";
#       Service.ExecStart = "${hdmiConnectedScript}";
#       Service.RemainAfterExit = "yes";
#     };
#
#     systemd.user.services.rh-hdmi-switch-disconnected = {
#       Unit.Description = "Switch back to laptop display when HDMI is disconnected";
#       Unit.PartOf = [ "graphical-session.target" ];
#       Unit.After = [ "graphical-session-pre.target" ];
#       Service.Type = "oneshot";
#       Service.ExecStart = "${hdmiDisconnectedScript}";
#       Service.RemainAfterExit = "yes";
#     };
#   };
# }
