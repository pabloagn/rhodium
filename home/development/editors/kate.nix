# home/development/editors/kate.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.development.editors.kate;
in {
  options.rhodium.development.editors.kate = {
    enable = mkEnableOption "Kate";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      kate
    ];
  };
}
