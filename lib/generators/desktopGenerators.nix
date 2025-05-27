{ lib, pkgs, config }:

let
  pathGenerators = import ./pathGenerators.nix { inherit config lib pkgs; };

  resolveIcon = icon:
    if icon != null && icon != ""
    then pathGenerators.generators.getLogoPath icon
    else null;

in
{
  generateDesktopEntries = config: dataFile:
    let
      entries = import dataFile { inherit config; };
    in
    lib.mapAttrs
      (name: entry:
        pkgs.makeDesktopItem (entry // {
          icon = resolveIcon entry.icon;
        })
      )
      entries;

  generateBookmarkEntries = config: dataFile:
    let
      bookmarks = import dataFile { inherit config; };

      bookmarkToDesktopEntry = name: bookmark: {
        inherit name;
        desktopName = bookmark.desktopName;
        genericName = "Bookmark";
        # TODO: Add browser switching logic here, but right now fine.
        exec = "${pkgs.firefox}/bin/firefox -P ${bookmark.profileName} ${if bookmark.newWindow or false then "--new-window" else ""} ${bookmark.url}";
        icon = resolveIcon bookmark.icon;
        comment = "Open ${bookmark.desktopName} in ${bookmark.browser or config.preferredApps.browser}";
        categories = [ "Network" "WebBrowser" ];
        type = "Application";
      };
    in
    lib.mapAttrs
      (name: bookmark:
        pkgs.makeDesktopItem (bookmarkToDesktopEntry name bookmark)
      )
      bookmarks;
}
