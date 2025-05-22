# home/apps/media/torrent/default.nix

{ config, lib, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  packageSpecs = [
    {
      name = "deluge";
      pkg = pkgs.deluge;
      description = "Lightweight BitTorrent client";
    }
    {
      name = "deluged";
      pkg = pkgs.deluged or pkgs.deluge-daemon;
      description = "Deluge BitTorrent daemon";
    }
    {
      name = "transmission";
      pkg = pkgs.transmission;
      description = "Fast, easy and free BitTorrent client";
    }
    {
      name = "qbittorrent";
      pkg = pkgs.qbittorrent;
      description = "Free and open source software application that allows you to manage your torrents";
    }
  ];
in
{
  options = setAttrByPath _haumea.configPath {
    enable = mkEnableOption "Rhodium's torrent applications";
  } // rhodiumLib.mkIndividualPackageOptions packageSpecs;

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;
  };
}
