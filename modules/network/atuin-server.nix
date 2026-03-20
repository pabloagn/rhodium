{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.extraServices.atuinSync;
in
{
  options.extraServices.atuinSync = {
    enable = mkEnableOption "Atuin self-hosted sync server (PostgreSQL-backed)";
  };

  config = mkIf cfg.enable {
    # Atuin sync server — listens on all interfaces so Tailscale peers can reach it.
    # Firewall only opens the port on the tailscale0 interface.
    services.atuin = {
      enable = true;
      host = "0.0.0.0";
      port = 8888;
      openRegistration = true;
      database.createLocally = true;
    };

    # Only allow Atuin traffic over the Tailscale interface
    networking.firewall.interfaces."tailscale0" = {
      allowedTCPPorts = [ 8888 ];
    };
  };
}
