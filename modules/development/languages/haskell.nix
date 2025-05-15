# modules/development/languages/haskell.nix
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.development.languages.haskell;
in
{
  options.modules.development.languages.haskell = {
    enable = mkEnableOption "Enable Haskell development environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Haskell Compiler
      ghc

      # Build Tools
      cabal-install
      stack

      # Language Server
      haskell-language-server

      # Linters
      hlint

      # Formatters
      ormolu
      # fourmolu
      # stylish-haskell

      # Hoogle for searching Haskell libraries by type signature or name
      hoogle
    ];
  };
}
