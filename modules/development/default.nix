# modules/development/default.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.system.development;
in

{
  imports = [
    ./virtualization
    ./editors
    ./languages
  ];

  options.rhodium.system.development = {
    enable = mkEnableOption "Enable development";
  };

  config = mkIf cfg.enable {
  };
}
