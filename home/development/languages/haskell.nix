{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.rh.development.languages.haskell;
in
{
  options.rh.development.languages.haskell = {
    enable = lib.mkEnableOption "Enable Haskell Language";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      haskell-language-server
      haskellPackages.fourmolu
      haskellPackages.cabal-install
      haskellPackages.hoogle
    ];
  };
}
