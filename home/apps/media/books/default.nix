# home/apps/media/books/default.nix

{ config, lib, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  packageSpecs = [
    # Managers
    {
      name = "calibre";
      pkg = [ pkgs.calibre pkgs.calibre-web ];
      description = "E-book manager";
    }
    {
      name = "komga";
      pkg = pkgs.komga;
      description = "A community-driven fork of Kodi for managing digital comics and manga";
    }
    {
      name = "kavita";
      pkg = pkgs.kavita;
      description = "A community-driven fork of Kodi for managing digital comics and manga";
    }
  ];
in
{
  options = setAttrByPath _haumea.configPath
    {
      enable = mkEnableOption "Books applications";
    } // rhodiumLib.mkIndividualPackageOptions packageSpecs;

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;
  };
}
