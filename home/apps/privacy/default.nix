# home/apps/privacy/default.nix

{ config, lib, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;

  packageSpecs = [
    # VPN
    {
      name = "protonvpn-cli";
      pkg = pkgs.protonvpn-cli;
      description = "ProtonVPN Command-Line Tool";
    }
    {
      name = "protonvpn-gui";
      pkg = pkgs.protonvpn-gui;
      description = "ProtonVPN Graphical User Interface";
    }
    {
      name = "wireguard-tools";
      pkg = pkgs.wireguard-tools;
      description = "WireGuard userspace tools (wg, wg-quick)";
    }

    # Metadata Anonymization
    {
      name = "mat2";
      pkg = pkgs.mat2;
      description = "Metadata Anonymisation Toolkit v2";
    }
  ];

in
{
  options = setAttrByPath _haumea.configPath
    {
      enable = mkEnableOption "Rhodium's Privacy tools";
    } // rhodiumLib.mkIndividualPackageOptions packageSpecs;

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;
  };
}
