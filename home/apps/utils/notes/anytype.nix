# home/apps/utils/notes/anytype.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.utils.notes.anytype;
in
{
  options.rhodium.apps.utils.notes.anytype = {
    enable = mkEnableOption "Rhodium's Anytype configuration";
  };

  config = mkIf (config.rhodium.apps.utils.notes.enable && cfg.enable) {
    home.packages = with pkgs; [
      anytype
    ];
  };
}
