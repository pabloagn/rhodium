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

  # NOTE: Self-hosted headscale
  # -------------------------------------------------------------------------------
  # systemd.services.tailscale-autoconnect = {
  #   description = "Connect to Headscale server";
  #   after = [
  #     "network-online.target"
  #     "tailscale.service"
  #   ];
  #   wants = [ "network-online.target" ];
  #   requires = [ "tailscale.service" ];
  #   wantedBy = [ "multi-user.target" ];
  #
  #   serviceConfig = {
  #     Type = "oneshot";
  #     RemainAfterExit = true;
  #     ExecStart = "${pkgs.tailscale}/bin/tailscale up --login-server=https://headscale.rhodium.sh --accept-routes";
  #   };
  # };
}
