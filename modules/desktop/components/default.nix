# modules/desktop/components/default.nix

{ lib, config, pkgs, ... }:
# TODO: Don't we need to install this as well? Of course we do.
{
  config = lib.mkIf (config.mySystem.hostProfile == "gui-desktop") {
    # Notification Daemon
    services.dunst.enable = lib.mkIf (config.mySystem.desktop.notificationDaemon == "dunst") true;
    services.mako.enable = lib.mkIf (config.mySystem.desktop.notificationDaemon == "mako") true;
    # Theming for these is done in modules/themes/apply.nix

    # Launcher (Rofi example, theming by apply.nix)
    programs.rofi.enable = lib.mkIf (config.mySystem.desktop.launcher == "rofi") true;

    # Status Bar (Waybar example, theming by apply.nix)
    programs.waybar.enable = lib.mkIf (config.mySystem.desktop.statusBar == "waybar") true;
  };
}
