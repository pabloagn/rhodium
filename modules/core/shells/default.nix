# modules/core/shells/default.nix

{ lib, config, pkgs, ... }:

{
  imports = [
    # Shells
    ./bash.nix
    ./fish.nix
    ./nushell.nix
    ./zsh.nix
    
    # Utils
    ./direnv.nix
    ./powerline.nix
    ./starship.nix
    ./tmux.nix
  ];
  config = {
    environment.systemPackages = lib.mapAttrsToList (name: value: pkgs."${name}")
      (lib.filterAttrs (name: value: lib.elem name config.mySystem.userShells.enable) {
        bash = pkgs.bash;
        fish = pkgs.fish;
        nushell = pkgs.nushell;
        zsh = pkgs.zsh;
      });

    users.defaultUserShell = pkgs."${config.mySystem.userShells.default or "bash"}";
  };
}

# Pendings:
# ---------------------------
# ./nushell.nix
# ./xonsh.nix
# ./powershell.nix
# ./elvish.nix
# ./ion.nix
# ./dash.nix
# ./ksh.nix
