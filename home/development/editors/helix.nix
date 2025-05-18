# home/development/editors/helix.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.development.editors.helix;
in
{
  options.rhodium.development.editors.helix = {
    enable = mkEnableOption "Rhodium's Helix configuration";
  };

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      package = pkgs.helix;
    };

    xdg.configFile = {
      "helix/config.toml" = { source = ./helix/config.toml; };
      "helix/languages.toml" = { source = ./helix/languages.toml; };
      "helix/themes/tokyonight.toml" = { source = ./helix/themes/tokyonight.toml; };
    };
  };
}
