# modules/development/languages/elm.nix
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.development.languages.elm;
in
{
  options.modules.development.languages.elm = {
    enable = mkEnableOption "Enable Elm development environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Elm Platform (compiler, repl, reactor, package manager)
      elmPackages.elm
      elmPackages.elm-format
      elmPackages.elm-language-server
      # elmPackages.elm-test # For testing
      # elmPackages.elm-json # For decoding/encoding JSON
    ];
  };
}
