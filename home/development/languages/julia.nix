# home/development/languages/julia.nix
{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.julia;
in
{
  options.home.development.languages.julia = {
    enable = mkEnableOption "Enable Julia development environment (Home Manager)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Julia runtime
      julia-bin # Or julia for building from source, julia-lts for LTS

      # Language Server (LanguageServer.jl) is typically installed via Julia's Pkg manager.
      # To make LanguageServer.jl available from Nix:
      # (julia-bin.withPackages (ps: [ ps.LanguageServer ps.SymbolServer ]))
      # However, managing it via Julia's Pkg manager inside a project is often preferred.
    ];
  };
}
