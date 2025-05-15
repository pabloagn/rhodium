{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.elm;
in
{
  options.home.development.languages.elm = {
    enable = mkEnableOption "Enable Elm development environment (Home Manager)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Elm Platform (compiler, repl, reactor, package manager)
      elmPackages.elm
      elmPackages.elm-format
      elmPackages.elm-language-server
      # elmPackages.elm-test # For testing
      # elmPackages.elm-json # For decoding/encoding JSON
    ];
  };
}
