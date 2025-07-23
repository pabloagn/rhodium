{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.rh.apps.media.audio.spotify;
in
{
  options.rh.apps.media.audio.spotify = {
    enable = lib.mkEnableOption "Enable Spotify client";

    withExtras = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Install extra Spotify-related tools (e.g. spotify-player)";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages =
      with pkgs;
      [
        spotify # Official Spotify client
      ]
      ++ lib.optionals cfg.withExtras [
        spotify-player # Terminal Spotify player that has feature parity with the official client
      ];
  };
}

