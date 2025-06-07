{ ... }:

{
  # fzfConfig = import ./fzf.nix { };
  defaults = import ./defaults.nix { };
  atuin = import ./atuin.nix { };
  keybinds = import ./keybinds.nix { };
  # abbreviations = import ./abbreviations.nix { inherit config; };
  theme = import ./theme.nix { };
  prompt = import ./prompt.nix { };
}
