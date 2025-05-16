# home/development/virtualization/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.development.virtualization;
in
{
  imports = [
    ./containers.nix
  ];

  options.rhodium.development.virtualization = {
    enable = mkEnableOption "Rhodium's virtualization tools";
  };
}
