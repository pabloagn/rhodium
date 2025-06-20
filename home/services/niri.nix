{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.niri-session;
in {
  options.services.niri-session = {
    enable = mkEnableOption "Niri session services (swaybg, waybar, mako)";
  };

  config = mkIf cfg.enable {
    # Swaybg wallpaper service
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

    # Waybar service
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

    # Mako notification daemon
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

    # Activation script to reload services on rebuild
    home.activation.reloadNiriServices = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ -n "$WAYLAND_DISPLAY" ]; then
        echo "Reloading Niri session services..."

        # Reload systemd user daemon
        ${pkgs.systemd}/bin/systemctl --user daemon-reload

        # Restart services
        for service in swaybg waybar mako; do
          echo "  Restarting $service..."
          ${pkgs.systemd}/bin/systemctl --user restart "$service.service" || true
        done

        echo "✓ Niri services reloaded"
      fi
    '';
  };
}
