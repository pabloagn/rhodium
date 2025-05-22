# home/development/editors/helix/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  editorConfig = import ./editor.nix { inherit config lib; };
  keysConfig = import ./keys.nix;
  languagesConfig = import ./languages.nix { inherit pkgs; };
  themeConfig = import ./themes.nix;

  # Helper functions
  helpers = {
    getClipboardProvider = wm:
      if elem wm ["i3" "dwm" "xmonad" "awesome" "bspwm" "openbox" "fluxbox"]
      then "x-clip"
      else "wl-clipboard";

    getCurrentWM = config.home.sessionVariables.WM or "hyprland";

    mergeLanguageConfig = base: overrides:
      recursiveUpdate base overrides;
  };

  # Configuration builder
  mkHelixConfig = {
    theme ? "phantom",
    customizations ? {},
    enabledLanguages ? "all", # "all", "minimal", or list of language names
  }:
  let
    baseConfig = {
      inherit theme;
      editor = editorConfig.mkEditorConfig {
        clipboardProvider = helpers.getClipboardProvider helpers.getCurrentWM;
      };
      keys = keysConfig.default;
    };

    # Apply customizations recursively
    customizedConfig = recursiveUpdate baseConfig customizations;

    # Filter languages if not "all"
    filteredLanguages =
      if enabledLanguages == "all" then languagesConfig.all
      else if enabledLanguages == "minimal" then languagesConfig.minimal
      else languagesConfig.filterByNames enabledLanguages;
  in
  customizedConfig;

in
{
  # Export the main configuration builder
  inherit mkHelixConfig;

  # Export individual components for fine-grained control
  inherit editorConfig keysConfig languagesConfig themeConfig helpers;

  # Pre-built configurations for different use cases
  profiles = {
    # Full-featured development setup
    developer = mkHelixConfig {
      theme = "phantom";
      enabledLanguages = "all";
      customizations = {
        editor.auto-format = true;
        editor.completion-trigger-len = 1;
      };
    };

    # Minimal configuration for quick editing
    minimal = mkHelixConfig {
      theme = "phantom";
      enabledLanguages = "minimal";
      customizations = {
        editor.auto-completion = false;
        editor.auto-format = false;
        editor.bufferline = "never";
      };
    };

    # Writing-focused configuration
    writer = mkHelixConfig {
      theme = "phantom";
      enabledLanguages = ["markdown" "latex" "toml"];
      customizations = {
        editor.soft-wrap.enable = true;
        editor.rulers = [80];
        editor.statusline.center = [];
      };
    };
  };

  default = profiles.developer;
}
