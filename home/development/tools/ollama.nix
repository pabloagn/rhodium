# home/development/tools/ollama.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.development.tools.ollama;
in
{
  options.rhodium.development.tools.ollama = {
    enable = mkEnableOption "Ollama";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ollama
    ];
  };
}
