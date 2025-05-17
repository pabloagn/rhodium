# home/system/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.system;
in
{
  imports = [
    ./monitoring
    ./networking
  ];

  options.rhodium.system = {
    enable = mkEnableOption "System utilities and tools";
  };

  config = mkIf cfg.enable { };
}
