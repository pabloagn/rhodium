{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Haskell ---
    haskell-language-server

    # --- Packages ---
    haskellPackages.fourmolu
    haskellPackages.cabal-install
    haskellPackages.hoogle
  ];
}
