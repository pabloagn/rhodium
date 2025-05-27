{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.desktop;

  desktopGenerator = import ../../lib/generators/desktopGenerators.nix { inherit lib pkgs config; };

  # Import data files
  # TODO: Eventually this is passed from the flake as user extra args
  appsData = ../../data/users/desktop/apps.nix;
  profilesData = ../../data/users/desktop/profiles.nix;
  bookmarksData = ../../data/users/desktop/bookmarks.nix;

  generatedApps = optionalAttrs cfg.apps.enable
    (desktopGenerator.generateDesktopEntries config appsData);

  generatedProfiles = optionalAttrs cfg.profiles.enable
    (desktopGenerator.generateDesktopEntries config profilesData);

  generatedBookmarks = optionalAttrs cfg.bookmarks.enable
    (desktopGenerator.generateBookmarkEntries config bookmarksData);

in
{
  options.desktop = {
    apps.enable = mkEnableOption "Desktop entries for applications";
    profiles.enable = mkEnableOption "Desktop entries for browser profiles";
    bookmarks.enable = mkEnableOption "Desktop entries for bookmarks";
  };

  config = mkIf (cfg.apps.enable || cfg.profiles.enable || cfg.bookmarks.enable) {
    home.packages = flatten [
      (attrValues generatedApps)
      (attrValues generatedProfiles)
      (attrValues generatedBookmarks)
    ];
  };
}
