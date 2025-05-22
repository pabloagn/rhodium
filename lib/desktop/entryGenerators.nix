# lib/desktop/entryGenerators.nix

{ lib, activeGenerators }:
{
  generateProfileLauncherItems = { profilesConfig, allBrowsersConfig }:
    if profilesConfig.enable or false then
      let
        profileDataList = profilesConfig.dataForUser or [ ];
        profileDataToLauncherArgs = profileEntryArg:
          map (browserKey: { profileData = profileEntryArg; inherit browserKey; }) (profileEntryArg.browsers or [ ]);
        launcherArgsList = lib.flatten (map profileDataToLauncherArgs profileDataList);
        generatedItems = map
          (args:
            let
              browserAppConfig = allBrowsersConfig.${args.browserKey} or {};
              browserAppIsEnabled = browserAppConfig.enable or false;
            in
            if browserAppIsEnabled then activeGenerators.mkBrowserProfileEntry args else null
          )
          launcherArgsList;
      in
      generatedItems
    else [ ];

  generateBookmarkLauncherItems = { bookmarksConfig }:
    if bookmarksConfig.enable or false then
      let bookmarkDataList = bookmarksConfig.dataForUser or [ ];
      in map activeGenerators.mkWebBookmarkEntry bookmarkDataList
    else [ ];

  generateApplicationLauncherItems = { launchableAppCategoriesData, currentFullConfig }:
    lib.flatten (lib.map
      (categoryInput:
        let
          categoryConfig = lib.getAttrFromPath categoryInput.optionPath currentFullConfig;
          pathStr = lib.concatStringsSep "." categoryInput.optionPath;
        in
        lib.mapAttrsToList
          (appName: appSpecificConfig:
            if lib.isAttrs appSpecificConfig &&
               (appSpecificConfig.enable or false) &&
               (appSpecificConfig.desktopEntry.enable or false)
            then
              activeGenerators.mkApplicationLauncherEntry {
                inherit appName appSpecificConfig;
                appPkgPath = "${pathStr}.${appName}";
              }
            else null
          )
          (lib.removeAttrs categoryConfig categoryInput.categoryLevelNonAppAttrs)
      )
      launchableAppCategoriesData
    );
}
