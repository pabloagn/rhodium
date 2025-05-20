# home/apps/privacy/default.nix

{ config, lib, pkgs, rhodium, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.privacy;

  packageSpecs = [
    # VPN
    { name = "protonvpn-cli"; pkg = pkgs.protonvpn-cli; description = "ProtonVPN Command-Line Tool"; }
    { name = "protonvpn-gui"; pkg = pkgs.protonvpn-gui; description = "ProtonVPN Graphical User Interface"; }
    { name = "wireguard-tools"; pkg = pkgs.wireguard-tools; description = "WireGuard userspace tools (wg, wg-quick)"; }

    # Metadata Anonymization
    { name = "mat2"; pkg = pkgs.mat2; description = "Metadata Anonymisation Toolkit v2"; }
  ];

in
{
  options.rhodium.home.apps.privacy = {
    enable = mkEnableOption "Rhodium's Privacy tools";
  } // rhodium.lib.mkIndividualPackageOptions packageSpecs;

  config = mkIf cfg.enable {
    home.packages = concatMap (spec: if cfg.${spec.name}.enable then [ spec.pkg ] else [ ]) packageSpecs;
  };
}
