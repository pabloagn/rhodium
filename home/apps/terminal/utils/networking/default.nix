# home/apps/terminal/utils/networking/default.nix

{ config, lib, pkgs, rhodium, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.terminal.utils.networking;
  categoryName = "networking";

  packageSpecs = [
    { name = "curl"; pkg = pkgs.curl; description = "URL retrieval utility"; }
    { name = "wget"; pkg = pkgs.wget; description = "Network downloader"; }
    { name = "httpie"; pkg = pkgs.httpie; description = "User-friendly HTTP client"; }
    { name = "xh"; pkg = pkgs.xh; description = "Friendly and fast HTTP client (Rust remake of HTTPie)"; }
    { name = "dog"; pkg = pkgs.dog; description = "DNS client like dig but more user-friendly"; }
    { name = "nmap"; pkg = pkgs.nmap; description = "Network scanner"; }
    { name = "iperf3"; pkg = pkgs.iperf3; description = "Network bandwidth testing"; }
    { name = "socat"; pkg = pkgs.socat; description = "Multipurpose relay for bidirectional data transfer"; }
  ];
in
{
  options.rhodium.home.apps.terminal.utils.${categoryName} = {
    enable = mkEnableOption "Rhodium's ${categoryName} terminal utils";
  } // rhodium.lib.mkIndividualPackageOptions packageSpecs;

  config = mkIf cfg.enable {
    home.packages = concatMap (spec: if cfg.${spec.name}.enable then [ spec.pkg ] else [ ]) packageSpecs;
  };
}
