{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.apps.media.audio.tidal;
in
{
  options.apps.media.audio.tidal = {
    enable = lib.mkEnableOption "Enable TIDAL CLI and GUI tools";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      tidal-dl # Downloader for tidal media
      tidal-hifi # Tidal GUI running on Electron
    ];
  };
}
