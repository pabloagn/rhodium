{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.tailscale = {
    enable = true;
    openFirewall = true;
  };

  systemd.services.tailscale-autoconnect = {
    description = "Connect to Headscale server";
    after = [
      "network-online.target"
      "tailscale.service"
    ];
    wants = [ "network-online.target" ];
    requires = [ "tailscale.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.tailscale}/bin/tailscale up --login-server=https://alexandria.tailnet:8080 --accept-routes";
    };
  };
}
