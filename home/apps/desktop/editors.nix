# home/apps/desktop/editors.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.desktop.editors;
  defs = import ../../lib/desktop-definitions.nix { inherit lib config pkgs; };
in
{
  options.rhodium.apps.desktop.editors = {
    enable = mkEnableOption "Desktop Editor Applications";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [

      # Helix Editor
      (makeDesktopItem {
        name = "helix-instance";
        desktopName = "Helix";
        genericName = defs.genericStrings.name.appEditor;
        exec = "${defs.terminal} --directory ${config.home.homeDirectory} hx %F";
        icon = defs.logos.helix;
        comment = "Edit text files in a terminal using Helix, detached from any terminal instance.";
        categories = [ "Utility" "TextEditor" ];
        terminal = false;
        type = "Application";
      })

      # Neovim Editor
      (makeDesktopItem {
        name = "nvim-instance";
        desktopName = "Neovim";
        genericName = defs.genericStrings.name.appEditor;
        exec = "${defs.terminal} --directory ${config.home.homeDirectory} nvim %F";
        icon = defs.logos.neovim;
        comment = "Edit text files in a terminal using NeoVim, detached from any terminal instance.";
        categories = [ "Utility" "TextEditor" ];
        terminal = false;
        type = "Application";
      })
    ];
  };
}
