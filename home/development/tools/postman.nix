# home/development/tools/postman.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.development.tools.postman;
in
{
  options.rhodium.development.tools.postman = {
    enable = mkEnableOption "Postman";
  };

  config = mkIf (config.rhodium.development.tools.enable && cfg.enable) {
    home.packages = with pkgs; [
      postman
    ];
  };
}
