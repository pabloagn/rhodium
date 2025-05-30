{ lib, config, pkgs, userPreferences, ... }:
let
  hyprSettings = [
    (import ./execs.nix { inherit config; })
    (import ./general.nix { })
    (import ./keybinds.nix { inherit lib config pkgs userPreferences; })
    (import ./monitors.nix { })
    (import ./rules.nix { })
    (import ./workspaces.nix { })
  ];
  # hyprPlugins = import ./plugins.nix { inherit lib config pkgs; };
in
{
  wayland.windowManager.hyprland = {
    settings = lib.foldr lib.mergeAttrs {} hyprSettings;
    # plugins = hyprPlugins;
  };
}
