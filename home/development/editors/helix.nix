# home/development/editors/helix.nix

{ lib, config, pkgs, ... }:

with lib;
let
  helixConfig = ./helix;
  helixThemes = helixConfig + "themes";
  cfg = config.rhodium.home.development.editors.helix;
  desktopDefs = config.rhodium.lib.desktopDefinitions;
in
{
  options.rhodium.home.development.editors.helix = {
    enable = mkEnableOption "Rhodium's Helix configuration";
  };

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      package = pkgs.helix;
    };

    xdg.configFile = {
      "helix/config.toml" = {
        source = "${helixConfig}/config.toml";
      };
      "helix/languages.toml" = {
        source = "${helixConfig}/languages.toml";
      };
      "helix/themes/tokyonight.toml" = {
        source = "${helixThemes}/tokyonight.toml";
      };
    };
  };
}
