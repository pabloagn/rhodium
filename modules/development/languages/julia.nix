# modules/development/languages/julia.nix
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.development.languages.julia;
in
{
  options.modules.development.languages.julia = {
    enable = mkEnableOption "Enable Julia development environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Julia runtime
      julia-bin # Or julia for building from source, julia-lts for LTS

      # Language Server (LanguageServer.jl) is typically installed via Julia's Pkg manager:
      # In Julia REPL:
      # import Pkg; Pkg.add("LanguageServer")
      # Pkg.add("SymbolServer")
    ];
    # To make LanguageServer.jl available, you might need to configure your editor
    # to use the Julia executable and find the server installed in the Julia environment.
  };
}
