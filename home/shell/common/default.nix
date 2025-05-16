# home/shell/common/default.nix
{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.shell;
in
{
  imports = [
    ./packages.nix
  ];

  config = mkIf cfg.enable {
    # Intentionally left empty, as shell packages are now defined in packages.nix
  };
}
