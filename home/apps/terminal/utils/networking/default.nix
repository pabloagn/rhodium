# home/apps/terminal/utils/networking/default.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  categoryName = _haumea.name;
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;

  packageSpecs = [
    # Network Exploration
    { name = "nmap"; pkg = pkgs.nmap; description = "Network exploration tool and security scanner"; }
    { name = "netcat"; pkg = pkgs.netcat; description = "Network utility for TCP/IP packet manipulation"; }
    { name = "socat"; pkg = pkgs.socat; description = "Multipurpose relay for bidirectional data transfer"; }
    { name = "tcpdump"; pkg = pkgs.tcpdump; description = "Command-line network traffic analyzer"; }
    { name = "wireshark"; pkg = pkgs.wireshark; description = "Network protocol analyzer"; }
    { name = "iperf"; pkg = pkgs.iperf; description = "Network bandwidth performance measurement tool"; }
    { name = "iperf3"; pkg = pkgs.iperf3; description = "Network bandwidth performance measurement tool"; }
    { name = "netcat"; pkg = pkgs.netcat; description = "Network utility for TCP/IP packet manipulation"; }

    # Network Monitoring
    { name = "iftop"; pkg = pkgs.iftop; description = "Network traffic monitor by interface"; }
    { name = "vnstat"; pkg = pkgs.vnstat; description = "Network traffic monitor and database"; }
    { name = "bandwhich"; pkg = pkgs.bandwhich; description = "Terminal bandwidth utilization tool"; }
  ];
in
{
  options = setAttrByPath _haumea.configPath
    {
      enable = mkEnableOption "Rhodium's ${categoryName} terminal utils";
    } // rhodiumLib.mkIndividualPackageOptions packageSpecs;

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;
  };
}
