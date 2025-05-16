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

  config = mkIf (config.rhodium.development.editors.enable && cfg.enable) {
    home.packages = with pkgs; [
      helix
    ];

    # Configuration - keeping your existing structure
    xdg.configFile = {
      "helix/config.toml" = { source = ./helix/config.toml; };
      "helix/languages.toml" = { source = ./helix/languages.toml; };
      "helix/themes/tokyonight.toml" = { source = ./helix/themes/tokyonight.toml; };
    };
  };
}
