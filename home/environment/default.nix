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
    # Common environment settings that apply to all shells and programs
  };
}
