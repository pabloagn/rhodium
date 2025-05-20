# home/development/default.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.home.development;
in
{
  imports = [
    ./databases
    ./editors
    ./languages
    ./tools
    ./virtualization
  ];

  options.rhodium.home.development = {
    enable = mkEnableOption "Enable development environment";
  };

  config = mkIf cfg.enable {
    rhodium.home.development = {
      databases.enable = true;
      editors.enable = true;
      languages.enable = true;
      tools.enable = true;
      virtualization.enable = true;
    };
  };
}
