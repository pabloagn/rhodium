{
  description = "Sample Haskell project with LSP support";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};

      haskellPackages = pkgs.haskellPackages;

      myHaskellPackage = haskellPackages.callCabal2nix "rhodium" ./. {};
    in {
      packages = {
        default = myHaskellPackage;
        rhodium = myHaskellPackage;
      };

      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          # Haskell toolchain
          haskellPackages.ghc
          haskellPackages.cabal-install
          haskellPackages.haskell-language-server
          haskellPackages.hlint
          haskellPackages.ormolu
          haskellPackages.hoogle

          # Development tools
          zlib
        ];
      };
    });
}
