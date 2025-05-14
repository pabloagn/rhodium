# modules/core/shells/default.nix

{ lib, config, pkgs, ... }:

let
  shellPkgs = {
    # Map option name to package name if different
    bash = pkgs.bashInteractive;
    zsh = pkgs.zsh;
    fish = pkgs.fish;
    nushell = pkgs.nushell;
  };
in
{
  config = {
    environment.systemPackages = map (shellName: shellPkgs."${shellName}") config.mySystem.userShells.enable;
    users.defaultUserShell = shellPkgs."${config.mySystem.userShells.defaultLoginShell}";

    # System-wide direnv and starship if desired (often better in Home Manager for user config)
    # programs.direnv.enable = true;
    # programs.starship.enable = true;
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
