{ config, lib, pkgs, ... }:
with lib;
{
  options = {
    programs.development.ml = {
      enable = mkEnableOption "ML development tools";
    };
  };

  config = mkIf config.programs.development.ml.enable {
    home.packages = with pkgs; [
      ollama
    ];
  };
}
