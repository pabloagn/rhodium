# home/apps/desktop/default.nix
# DONE

{ lib, config, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.desktop;
in
{
  imports = [
    ./editors.nix
    ./image-viewers.nix
    ./firefox-profiles.nix
    ./bookmarks.nix
  ];

  options.rhodium.home.apps.desktop = {
    enable = mkEnableOption "Rhodium's desktop applications";
  };

  config = mkIf cfg.enable {
    rhodium.home.apps.desktop = {
      editors.enable = false;
      imageViewers.enable = false;
      firefoxProfiles.enable = false;
      bookmarks.enable = false;
    };
  };
}
