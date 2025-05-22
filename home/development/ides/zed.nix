# home/development/editors/zed.nix

{ lib, config, pkgs, ... }:

with lib;
let
  zedConfig = ./zed;
  zedThemes = zedConfig + "/themes";
  zedSnippets = zedConfig + "/snippets";
  cfg = config.rhodium.home.development.editors.zed;
in
{
  options.rhodium.home.development.editors.zed = {
    enable = mkEnableOption "Rhodium's Zed configuration";
  };

  config = mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
      package = pkgs.zed-editor;
      extensions = [ "nix" ];
      userKeymaps = { };
      userSettings = { };
    };

    xdg.configFile = {
      "zed/settings.json" = {
        source = "${zedConfig}/settings.json";
      };
      "zed/keymap.json" = {
        source = "${zedConfig}/keymap.json";
      };
      "zed/snippets/snippets.json" = {
        source = "${zedSnippets}/snippets.json";
      };
      "zed/themes/phantom.json" = {
        source = "${zedThemes}/phantom.json";
      };
    };
  };
}
