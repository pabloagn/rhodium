# home/development/tools/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.development.tools;
in
{
  imports = [
    ./ollama.nix
    ./postman.nix
  ];

  options.rhodium.development.tools = {
    enable = mkEnableOption "Rhodium's development tools";
  };

  config = mkIf cfg.enable {
    home.development.tools.ollama.enable = true;
    home.development.tools.postman.enable = true;
  };
}
