{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.apps.media.audio.vcv-rack;
in
{
  options.apps.media.audio.vcv-rack = {
    enable = lib.mkEnableOption "Enable VCV Rack modular synth";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      vcv-rack
    ];
  };
}
