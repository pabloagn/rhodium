# home/development/default.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.home.development;
  parentCfg = config.rhodium.home;
  categoryName = "development";
in
{
  imports = [
    ./databases/default.nix
    ./editors/default.nix
    ./languages/default.nix
    ./tools/default.nix
    ./virtualization/default.nix
  ];

  options.rhodium.home.${categoryName} = {
    enable = mkEnableOption "Enable ${categoryName}" // { default = false; };
  };

  config = rhodium.lib.mkChildConfig parentCfg cfg {
    rhodium.home.${categoryName} = {
      databases.enable = false;
      editors.enable = false;
      languages.enable = false;
      tools.enable = false;
      virtualization.enable = false;
    };
  };
}
