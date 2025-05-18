# home/apps/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps;
in {
  imports = [
    ./browsers
    ./communication
    ./desktop
    ./documents
    ./files
    ./media
    ./terminal
    ./utils
  ];

  options.rhodium.apps = {
    enable = mkEnableOption "Rhodium's applications";
  };

  config = mkIf cfg.enable {
    rhodium.apps.browsers.enable = true;
    rhodium.apps.communication.enable = true;
    rhodium.apps.desktop.enable = true;
    rhodium.apps.documents.enable = true;
    rhodium.apps.files.enable = true;
    rhodium.apps.media.enable = true;
    rhodium.apps.terminal.enable = true;
    rhodium.apps.utils.enable = true;
  };
}
