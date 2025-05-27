{ lib, config, pkgs, ... }:

let
  hyprSettings = [
    (import ./execs.nix { inherit lib config pkgs; })
    (import ./general.nix { inherit lib config pkgs; })
    (import ./keybinds.nix { inherit lib config pkgs; })
    (import ./monitors.nix { inherit lib config pkgs; })
    (import ./rules.nix { inherit lib config pkgs; })
    (import ./workspaces.nix { inherit lib config pkgs; })
  ];

  # hyprPlugins = import ./plugins.nix { inherit lib config pkgs; };
in
{
  wayland.windowManager.hyprland = {
    settings = lib.mergeAttrs hyprSettings;
    # plugins = hyprPlugins;
  };
}
