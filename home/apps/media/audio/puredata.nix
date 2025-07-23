{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.apps.media.audio.puredata;
in
{
  options.apps.media.audio.puredata = {
    enable = lib.mkEnableOption "Enable PureData";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      maxl # PureData non-tilde externals
      puredata # Real time interface for audio & video signal processing
      timbreid # PureData Utils
      zexy # PureData utils
    ];
  };
}
