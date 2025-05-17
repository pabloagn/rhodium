# home/development/editors/rstudio.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.development.editors.rstudio;
in
{
  home.packages = with pkgs; [
    rstudio
  ];
}
