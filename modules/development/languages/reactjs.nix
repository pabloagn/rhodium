# modules/development/languages/reactjs.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.system.development.languages.reactjs;
in
{
  options.rhodium.system.development.languages.reactjs = {
    enable = mkEnableOption "Enable React.js development environment";
  };

  config = mkIf cfg.enable {
    # React.js relies heavily on Node.js, TypeScript/JavaScript.
    # Ensure nodejs.nix and typescript.nix (if using TS) are also enabled.
    environment.systemPackages = with pkgs; [
      # CLI for bootstrapping React projects (though Vite is often preferred now)
      # nodePackages.create-react-app

      # Core dependencies like Node.js are expected to be provided by nodejs.nix
      # LSPs/Linters/Formatters are expected from javascript.nix/typescript.nix
    ];
    # Recommendation: Manage React.js and its dependencies per-project using package.json.
    # This module primarily serves as a marker or for global React utilities if any.
  };
}
