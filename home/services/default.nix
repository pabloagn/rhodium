{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./waybar.nix
    ./mako.nix
    ./swaybg.nix
    ./eww.nix
    ./wlsunset.nix
  ];

  # Activation script to reload services on rebuild
  home.activation.reloadNiriServices = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ -n "$WAYLAND_DISPLAY" ]; then
      echo "Reloading Niri session services..."

      # Reload systemd user daemon
      ${pkgs.systemd}/bin/systemctl --user daemon-reload

      # TODO: This must be dynamic based on user's service selection
      # Restart services
      for service in rh-swaybg rh-waybar rh-mako rh-wlsunset; do
        echo "  Restarting $service..."
        ${pkgs.systemd}/bin/systemctl --user restart "$service.service" || true
      done

      echo "✓ Niri services reloaded"
    fi
  '';
}
