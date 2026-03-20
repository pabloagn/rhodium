{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.extraServices.plex;
in
{
  options.extraServices.plex = {
    enable = mkEnableOption "Open firewall ports for Plex Media Server (TCP 32400)";
  };

  config = mkIf cfg.enable {
    networking.firewall = {
      allowedTCPPorts = [ 32400 ];
    };
  };
}
