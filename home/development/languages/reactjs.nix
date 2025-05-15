# home/development/languages/reactjs.nix
{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.reactjs;
in
{
  options.home.development.languages.reactjs = {
    enable = mkEnableOption "Enable React.js development tools (Home Manager)";
  };

  config = mkIf cfg.enable {
    # React.js relies heavily on Node.js. Ensure home.development.languages.nodejs is enabled.
    # LSPs/Linters/Formatters are expected from javascript.nix/typescript.nix.
    home.packages = with pkgs; [
      # CLI for bootstrapping React projects (though Vite is often preferred now)
      # nodePackages.create-react-app # If you want this globally
    ];
    # Recommendation: Manage React.js and its dependencies per-project using package.json.
  };
}
