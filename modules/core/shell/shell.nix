# modules/core/shell/shell.nix

{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.rhodium.system.core.shell;
in
{
  options.rhodium.system.core.shell = {
    enable = mkEnableOption "Rhodium core shell configuration (system-wide)";
    defaultUserShellPackage = mkOption {
      type = types.package;
      default = pkgs.zsh;
      defaultText = literalExpression "pkgs.zsh";
      description = "System-wide default user shell package.";
    };

    enableZshProgram = mkOption {
      type = types.bool;
      default = true;
      description = "Enable programs.zsh.enable system-wide.";
    };

    installStarship = mkOption {
      type = types.bool;
      default = true;
      description = "Install starship globally.";
    };

    availableShellPackages = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [ zsh bash ];
      defaultText = literalExpression "with pkgs; [ zsh bash ]";
      description = "Shell packages to make available system-wide.";
    };
  };

  config = mkIf cfg.enable {
    environment.shells = cfg.availableShellPackages;
    users.defaultUserShell = cfg.defaultUserShellPackage;
    programs.zsh.enable = cfg.enableZshProgram;
    environment.systemPackages = lib.optional cfg.installStarship pkgs.starship;
  };
}
