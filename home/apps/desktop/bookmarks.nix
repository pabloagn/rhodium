# home/apps/desktop/bookmarks.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.desktop.bookmarks;
  defs = import ../../lib/desktop-definitions.nix { inherit lib config pkgs; };
  bookmarkEntriesData = import ../../lib/bookmarks.nix;

  mkBookmarkFromData = entry:
    let
      browserType = entry.browser or "firefox";
      browserPackage = if browserType == "zen" then defs.zenPackage else defs.firefoxPackage;
      browserBinary = if browserType == "zen" then "zenith" else "firefox";
      actualComment = entry.comment or "Launch ${entry.siteName} with ${entry.profileName} profile in ${browserType}.";
      genericNameString = defs.genericStrings.profiles.${entry.profileCategoryKey} or defs.genericStrings.profiles.defaultWeb;
      iconPath = defs.logos.${entry.logoName} or "";

    in
    makeDesktopItem {
      name = "${browserType}-${entry.idName}";
      desktopName = entry.siteName;
      genericName = "${defs.genericStrings.prefix.webApp} - ${genericNameString}";
      exec = "${browserPackage}/bin/${browserBinary} -P ${entry.profileName} ${defs.browserNewWindowArg} ${lib.escapeShellArg entry.url}";
      icon = iconPath;
      comment = actualComment;
      categories = entry.categories or defs.defaultWebBookmarkCategories;
      mimeTypes = entry.mimeTypes or defs.defaultWebBookmarkMimeTypes;
      type = "Application";
      terminal = false;
    };

in
{
  options.rhodium.home.apps.desktop.bookmarks = {
    enable = mkEnableOption "Bookmark Desktop Entries";
  };

  config = mkIf cfg.enable {
    home.packages = map mkBookmarkFromData bookmarkEntriesData;
  };
}
