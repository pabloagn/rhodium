{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.extraServices.roon;
in
{
  options.extraServices.roon = {
    enable = mkEnableOption "Open firewall ports for Roon Server (TCP 9100-9200, 9330-9332, 55000; UDP 9003)";
  };

  config = mkIf cfg.enable {
    networking.firewall = {
      allowedTCPPortRanges = [
        { from = 9100; to = 9200; }
        { from = 9330; to = 9332; }
      ];
      allowedTCPPorts = [ 55000 ];
      allowedUDPPorts = [ 9003 ];
    };
  };
}
