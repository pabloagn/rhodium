# home/development/languages/nextjs.nix
{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.nextjs;
in
{
  options.home.development.languages.nextjs = {
    enable = mkEnableOption "Enable Next.js development tools (Home Manager)";
  };

  config = mkIf cfg.enable {
    # Next.js relies heavily on Node.js. Ensure home.development.languages.nodejs is enabled.
    # LSPs/Linters/Formatters are expected from javascript.nix/typescript.nix.
    home.packages = with pkgs; [
      # Global Next.js CLI (create-next-app) can be useful
      # nodePackages.next # If you want `create-next-app` globally
    ];
    # Recommendation: Manage Next.js and its dependencies per-project using package.json.
  };
}
