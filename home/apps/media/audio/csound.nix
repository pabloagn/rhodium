{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.apps.media.audio.csound;
in
{
  options.apps.media.audio.csound = {
    enable = lib.mkEnableOption "Enable CSound";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      csound
    ];
  };
}
