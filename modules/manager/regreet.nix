{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.manager.regreet;
in
{
  options.manager.regreet = {
    enable = mkEnableOption "ReGreet display manager with custom configuration";
  };

  config = mkIf cfg.enable {
    programs.regreet = {
      enable = true;
      settings = {
        background = {
          path = "/etc/regreet/wallpaper-01.jpg";
          fit = "Cover";
        };
        GTK = {
          application_prefer_dark_theme = true;
        };
        commands = {
          reboot = [
            "systemctl"
            "reboot"
          ];
          poweroff = [
            "systemctl"
            "poweroff"
          ];
        };
      };
    };
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "env GTK_USE_PORTAL=0 GDK_DEBUG=no-portals ${pkgs.hyprland}/bin/Hyprland --config /etc/greetd/hyprland.conf";
          user = "greeter";
        };
      };
    };
    environment.etc."greetd/hyprland.conf".text = ''
      exec-once = ${pkgs.greetd.regreet}/bin/regreet; hyprctl dispatch exit
      misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
        disable_hyprland_qtutils_check = true
      }
      animations {
        enabled = false
      }
      env = GTK_USE_PORTAL,0
      env = GDG_DEBUG,no-portals
      monitor = eDP-1,2880x1620@120,0x0,1.5
      monitor = HDMI-A-1,3840x2160@60,0x0,1.5
    '';
    systemd.tmpfiles.rules = [
      "d /var/lib/regreet 0755 greeter greeter - -"
      "d /var/log/regreet 0755 greeter greeter - -"
    ];
    environment.systemPackages = with pkgs; [
      greetd.regreet
    ];
    security.pam.services.greetd.enableGnomeKeyring = true;
    environment.etc."regreet/wallpaper-01.jpg".source =
      ../../home/assets/wallpapers/dante/wallpaper-01.jpg;
    services.displayManager.sessionPackages = [ pkgs.hyprland ];
    environment.pathsToLink = [
      "/share/xsessions"
      "/share/wayland-sessions"
    ];
  };
}
