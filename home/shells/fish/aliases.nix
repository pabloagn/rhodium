{...}: let
  aliases = import ../common/aliases.nix {};
in {
  programs.fish = {
    shellAliases = aliases;
  };
}
