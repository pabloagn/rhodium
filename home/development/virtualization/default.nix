# home/development/virtualization/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.development.virtualization;
in
{
  imports = [
    ./containers
    ./vm
  ];

  options.rhodium.development.virtualization = {
    enable = mkEnableOption "Rhodium's virtualization tools";
  };

  config = mkIf cfg.enable {
    home.development.virtualization.containers.enable = true;
    home.development.virtualization.vm.enable = true;
  };
}
