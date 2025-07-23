{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.apps.media.audio.sonicpi;
in
{
  options.apps.media.audio.sonicpi = {
    enable = lib.mkEnableOption "Enable Sonic Pi";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      sonic-pi
    ];
  };
}
