{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.services.tailscale-client = {
    enable = lib.mkEnableOption "Enable Tailscale client for use with Headscale";
    loginServer = lib.mkOption {
      type = lib.types.str;
      default = "https://alexandria.tailnet:8080";
      description = "URL of the Headscale coordination server";
    };
  };

  config = lib.mkIf config.services.tailscale-client.enable {
    environment.systemPackages = [ pkgs.tailscale ];

    systemd.services.tailscaled = {
      description = "Tailscale client daemon";
      after = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = ''
          ${pkgs.tailscale}/bin/tailscaled \
            --state=/var/lib/tailscale/tailscaled.state \
            --socket=/run/tailscale/tailscaled.sock \
            --login-server=${config.services.tailscale-client.loginServer}
        '';
        Restart = "always";
        RuntimeDirectory = "tailscale";
        CacheDirectory = "tailscale";
      };
    };

    # Optional: open web UI locally for debugging
    networking.firewall.allowedTCPPorts = [ 41641 ];
  };
}
