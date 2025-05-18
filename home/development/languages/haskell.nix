# home/development/languages/haskell.nix

{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.haskell;
in
{
  options.home.development.languages.haskell = {
    enable = mkEnableOption "Enable Haskell development environment (Home Manager)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
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
