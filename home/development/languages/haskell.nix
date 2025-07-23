# {
#   config,
#   lib,
#   pkgs,
#   ...
# }:
#
# let
#   cfg = config.rh.development.languages.haskell;
# in
# {
#   options.rh.development.languages.haskell = {
#     enable = lib.mkEnableOption "Enable Haskell Language";
#   };
#
#   config = lib.mkIf cfg.enable {
#     home.packages = with pkgs; [
#       haskell-language-server
#       haskellPackages.fourmolu
#       haskellPackages.cabal-install
#       haskellPackages.hoogle
#     ];
#   };
# }


{ config, lib, pkgs, ... }:

let
  builders = import ../../../lib/generators/moduleBuilder.nix {inherit lib; };
in
builders.mkLangModule {
  optionPath = [ "rh" "development" "languages" "haskell" ];
  description = "Enable Haskell Language";
  packages = with pkgs; [
    haskell-language-server
    haskellPackages.fourmolu
    haskellPackages.cabal-install
    haskellPackages.hoogle
  ];
}
