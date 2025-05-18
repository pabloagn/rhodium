# home/apps/desktop/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.desktop;
in
{
  imports = [
    ./editors.nix
    ./image-viewers.nix
    ./firefox-profiles.nix
    ./bookmarks.nix
  ];

  options.rhodium.apps.desktop = {
    enable = mkEnableOption "Rhodium's desktop applications";
  };

  config = mkIf cfg.enable {
    rhodium.apps.desktop.editors.enable = true;
    rhodium.apps.desktop.imageViewers.enable = true;
    rhodium.apps.desktop.firefoxProfiles.enable = true;
    rhodium.apps.desktop.bookmarks.enable = true;
  };
}
