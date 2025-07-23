{ config, lib, ... }:

let
  cfg = config.apps.media.audio.rmpc;
in
{
  options.apps.media.audio.rmpc = {
    enable = lib.mkEnableOption "Enable rmpc terminal MPD client";
  };

  config = lib.mkIf cfg.enable {
    programs.rmpc = {
      enable = true; # Beautiful, modern and configurable terminal based Music Player Daemon client
    };
  };
}

