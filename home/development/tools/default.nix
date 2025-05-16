# home/development/tools/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.development.tools;
in
{
  options.rhodium.development.tools = {
    enable = mkEnableOption "Rhodium's development tools";
  };

  config = mkIf cfg.enable {
    # Requirements
    home.packages = with pkgs; [
      postman
      ollama
    ];
  };
}
