# home/virtualization/compatibility/wine.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  categoryName = _haumea.name;
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
in
{
  options = setAttrByPath _haumea.configPath {
    enable = mkEnableOption "Rhodium's ${categoryName} configuration";
  };

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = with pkgs; [
      # TODO: Eventually add option for selecting which wine version to install
      wine
      wine-wayland
    ];
  };
}
