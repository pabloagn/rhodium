# lib/desktop/generators.nix

# lib/desktop-entry-helpers.nix
{ lib, pkgs, constants, config, paths }: # constants, config, paths are all passed in

with lib;
let
  # Smart logo getter
  getLogo =
    {
      # A suggested key for the logo.
      # For bookmarks/profiles: comes from dataEntry.logoKey (new field) or a derived hint.
      # For apps: comes from de.iconKeyOverride or derived from appName.
      logoKey
    , appPkg ? null
    , # Only for application launchers
      entryType ? "application" # "application", "webBookmark", "profile" for fallback context
    }:
    let
      # 1. Check if logoKey is in the small explicitLogoMap (for aliases/exceptions)
      fromExplicitMap =
        if constants.explicitLogoMap ? logoKey
        then constants.explicitLogoMap.${logoKey}
        else null;

      # 2. Convention: Try logoKey.png directly in the assets/logos directory.
      #    (Assuming logoKey is already cleaned, e.g., "youtube", "github", "helix")
      conventionPathPng = "${paths.assets.logos}/${logoKey}.png";
      fromConvention =
        if builtins.pathExists conventionPathPng
        then conventionPathPng
        else null;

      # 3. Application package metadata (only if appPkg is provided)
      fromAppMeta =
        if appPkg != null && appPkg ? meta && appPkg.meta ? icon
        then appPkg.meta.icon
        else null;

      # 4. Fallback generic icon using defaultLogoKey based on entryType
      fallbackTypeKey = constants.defaultLogoKey.${entryType} or constants.defaultLogoKey.application;
      fallbackIcon = constants.explicitLogoMap.${fallbackTypeKey} or null; # Look up the fallback key in the map

    in
      fromExplicitMap or fromConvention or fromAppMeta or fallbackIcon;

in
{
  # --- Helper for Web Bookmark Launchers ---
  mkWebBookmarkEntry = bookmarkData:
    let
      # For bookmarks, use bookmarkData.logoKey if provided.
      # If not, derive a hint from siteName or idName for the logoKey.
      logoKeyValue = bookmarkData.logoKey or (toLower (replaceStrings [ " " ] [ "-" ] bookmarkData.siteName));
      logo = getLogo { logoKey = logoKeyValue; entryType = "webBookmark"; };
      # ... rest of bookmark logic ...
    in
    pkgs.makeDesktopItem { /* ... icon = logo; ... */ };

  # --- Helper for Application Launchers ---
  mkApplicationLauncherEntry = { appName, appConfig, appPkgPath }:
    let
      de = appConfig.desktopEntry; # User's overrides for this app
      appActualPackage = appConfig.package or pkgs.${appName} or null;
      # For apps, use de.iconKeyOverride if provided by user.
      # If not, use appName as the conventional logoKey.
      logoKeyValue = de.iconKeyOverride or (toLower appName);
      logo = getLogo { logoKey = logoKeyValue; appPkg = appActualPackage; entryType = "application"; };
      # ... rest of app launcher logic ...
    in
    pkgs.makeDesktopItem { /* ... icon = logo; ... */ };

  # --- Helper for Browser Profile Launchers ---
  mkBrowserProfileEntry = profileData:
    let
      # For profiles, use profileData.logoKey if provided.
      # If not, derive a hint (e.g., from profileData.browser or profileData.siteName)
      logoKeyValue = profileData.logoKey or (toLower profileData.browser); # Example hint
      logo = getLogo { logoKey = logoKeyValue; entryType = "profile"; };
      # ... rest of profile logic ...
    in
    pkgs.makeDesktopItem { /* ... icon = logo; ... */ };
}
