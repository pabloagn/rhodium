# home/apps/communication/social/default.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  categoryName = _haumea.name;
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  packageSpecs = [
    {
      name = "mastodon";
      pkg = pkgs.mastodon;
      description = "Mastodon client";
    }
    {
      name = "discord";
      pkg = pkgs.discord;
      description = "Discord client";
    }
  ];
in
{
  options = setAttrByPath _haumea.configPath {
    enable = mkEnableOption "Rhodium's ${categoryName} applications" // { default = false; };
  };

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;
  };
}
