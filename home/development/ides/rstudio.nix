# home/development/editors/rstudio.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.development.editors.rstudio;
in
{
  options.rhodium.home.development.editors.rstudio = {
    enable = mkEnableOption "Rhodium's RStudio configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      rstudio
    ];
  };
}
