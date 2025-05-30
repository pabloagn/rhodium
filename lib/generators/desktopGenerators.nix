{ lib, ... }:
let
  # Browser-specific argument templates
  browserConfigs = {
    firefox = {
      profileFlag = "-P";
      newWindowFlag = "-new-window";
      executable = "firefox";
    };
    zen = {
      profileFlag = "--profile";
      newWindowFlag = "--new-window";
      executable = "zen-browser";
    };
    chromium = {
      profileFlag = "--profile-directory";
      newWindowFlag = "--new-window";
      executable = "chromium";
    };
    brave = {
      profileFlag = "--profile-directory";
      newWindowFlag = "--new-window";
      executable = "brave";
    };
  };

  # Capitalize first letter for descriptions
  capitalize = str:
    lib.toUpper (lib.substring 0 1 str) + lib.substring 1 (-1) str;

  # Flatten nested attribute set into flat structure with combined keys
  flattenNestedAttrs = attrs:
    lib.concatMapAttrs (topKey: topValue:
      lib.mapAttrs' (subKey: subValue: {
        name = "${topKey}-${subKey}";
        value = subValue;
      }) topValue
    ) attrs;

  # Bookmark generator: Browser + profile + URL
  mkBookmark = userPreferences: name: bookmark:
    let
      defaultBrowser = userPreferences.apps.browser;
      browser = bookmark.browser or defaultBrowser;
      browserConfig = browserConfigs.${browser} or browserConfigs.${defaultBrowser};
      profileName = userPreferences.profiles.${browser}.${bookmark.profile} or bookmark.profile;
    in {
      binary = browserConfig.executable;
      args = [
        browserConfig.profileFlag
        profileName
        browserConfig.newWindowFlag
        bookmark.url
      ];
      icon = browser;
      description = "[B] | ${bookmark.description} | ${capitalize browser} ${profileName}";
    };

  # Profile generator: Browser + profile only
  mkProfile = userPreferences: name: profile:
    let
      defaultBrowser = userPreferences.apps.browser;
      browser = profile.browser or defaultBrowser;
      browserConfig = browserConfigs.${browser} or browserConfigs.${defaultBrowser};
      profileName = userPreferences.profiles.${browser}.${profile.profile} or profile.profile;
    in {
      binary = browserConfig.executable;
      args = [
        browserConfig.profileFlag
        profileName
        browserConfig.newWindowFlag
      ];
      icon = browser;
      description = "[P] | ${capitalize browser} ${profileName}";
    };

  # App generator: Custom binary + flexible args
  mkApp = userPreferences: name: app: {
    binary = app.binary;
    args = app.args;
    icon = app.icon;
    description = "[A] | ${app.description}";
  };

in
{
  inherit mkBookmark mkProfile mkApp flattenNestedAttrs;

  # Generate all entries from imported data
  generateAllEntries = userPreferences: userExtras:
    let
      # Partially apply userPreferences to each generator function
      bookmarkGen = mkBookmark userPreferences;
      profileGen = mkProfile userPreferences;
      appGen = mkApp userPreferences;

      # Flatten nested structures and generate entries for each type
      bookmarkEntries = lib.mapAttrs bookmarkGen (flattenNestedAttrs userExtras.bookmarksData);
      profileEntries = lib.mapAttrs profileGen (flattenNestedAttrs userExtras.profilesData);
      appEntries = lib.mapAttrs appGen (flattenNestedAttrs userExtras.appsData);
    in
    bookmarkEntries // profileEntries // appEntries;
}
