{ config, pkgs, ... }:

{
  environment = import ./environment.nix { inherit config; };
  fzfConfig = import ./fzf.nix { };
  defaults = import ./defaults.nix { };
  atuin = import ./atuin.nix { };
  keybinds = import ./keybinds.nix { };
  abbreviations = import ./abbreviations.nix { inherit config; };
  theme = import ./theme.nix { };
  prompt = import ./prompt.nix { };
  functions = import ./functions.nix { inherit config pkgs; };
}
