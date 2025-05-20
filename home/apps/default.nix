# home/apps/default.nix
# DONE
{ config, lib, ... }:

with lib;
let
  cfg = config.rhodium.home.apps;
in
{
  imports = [
    ./browsers/default.nix
    ./communication/default.nix
    ./desktop/default.nix
    ./documents/default.nix
    ./editors/default.nix
    ./files/default.nix
    ./media/default.nix
    ./opsec/default.nix
    ./privacy/default.nix
    ./terminal/default.nix
    ./utils/default.nix
  ];

  options.rhodium.home.apps = {
    enable = mkEnableOption "Rhodium's applications";
  };

  config = mkIf cfg.enable {
    rhodium.home.apps.browsers.enable = true;
    rhodium.home.apps.communication.enable = true;
    rhodium.home.apps.desktop.enable = true;
    rhodium.home.apps.documents.enable = true;
    rhodium.home.apps.editors.enable = true;
    rhodium.home.apps.files.enable = true;
    rhodium.home.apps.media.enable = true;
    rhodium.home.apps.opsec.enable = true;
    rhodium.home.apps.privacy.enable = true;
    rhodium.home.apps.terminal.enable = true;
    rhodium.home.apps.utils.enable = true;
  };
}
