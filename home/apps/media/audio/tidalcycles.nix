{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.rh.apps.media.audio.tidalcycles;
in
{
  imports = [
    ../../../development
  ];

  options.rh.apps.media.audio.tidalcycles = {
    enable = lib.mkEnableOption "Enable TidalCycles";
  };

  config = lib.mkIf cfg.enable {
    rh.development.languages.haskell = {
      enable = true;
    };
    home.packages = with pkgs; [
      haskellPackages.tidal
    ];
  };
}
