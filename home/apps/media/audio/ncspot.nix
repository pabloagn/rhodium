{ config, lib, ... }:

let
  cfg = config.apps.media.audio.ncspot;
in
{
  options.apps.media.audio.ncspot = {
    enable = lib.mkEnableOption "Enable ncspot TUI Spotify client";
  };

  config = lib.mkIf cfg.enable {
    programs.ncspot = {
      enable = true;

      settings = {
        gapless = true;
      };
    };
  };
}
