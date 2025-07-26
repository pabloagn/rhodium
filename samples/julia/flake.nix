{
  description = "Julia flake with LSP and Data Science support";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        juliaPackages = [
          "LanguageServer"
          "SymbolServer"
          "StaticLint"
          "DataFrames"
          "CSV"
          "Plots"
          "StatsBase"
          "Distributions"
          "GLM"
          "Query"
          "Gadfly"
        ];
        juliaEnv = pkgs.julia.withPackages juliaPackages;
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [ juliaEnv ];
        };
      });
}
