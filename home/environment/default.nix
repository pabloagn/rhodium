# home/environment/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.environment;
in
{
  imports = [
    ./variables.nix
    ./mime.nix
    ./paths.nix
  ];

  options.rhodium.environment = {
    enable = mkEnableOption "Rhodium's environment configuration";
  };

  config = mkIf cfg.enable {
    home.environment.mime.enable = true;
    home.environment.paths.enable = true;
    home.environment.variables.enable = true;
  };
}
