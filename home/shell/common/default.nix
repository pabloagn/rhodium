# home/shell/common/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.shell;
in
{
  imports = [
  ];

  config = mkIf cfg.enable {
  };
}
