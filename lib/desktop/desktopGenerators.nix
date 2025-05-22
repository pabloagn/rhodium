# lib/desktop/desktopGenerators.nix

{ lib, pkgs, desktopConstants, config, paths }:

with lib;
let
  nameSuffixApp = "rhodium-desktop";
  nameSuffixProfile = "rhodium-profile";
  nameSuffixBookmark = "rhodium-bookmark";

  getLogo = { logoKey, appPkg ? null, entryType ? "application" }:
    let
      fromExplicitMap = desktopConstants.explicitLogoMap.${logoKey} or null;
      conventionPathPng = "${paths.assets.logos}/${logoKey}.png";
      fromConvention = if builtins.pathExists conventionPathPng then conventionPathPng else null;
      fromAppMeta = if appPkg != null && appPkg ? meta && appPkg.meta ? icon then appPkg.meta.icon else null;
      fallbackTypeKey = desktopConstants.defaultLogoKey.${entryType} or desktopConstants.defaultLogoKey.application;
      fallbackIcon = desktopConstants.explicitLogoMap.${fallbackTypeKey} or null;
    in
      fromExplicitMap or fromConvention or fromAppMeta or fallbackIcon;
in
{
  mkBrowserProfileEntry = { profileData, browserKey }:
    let
      browserInfo = desktopConstants.browserExecutables.${browserKey} or (abort "Unknown browser key '${browserKey}' in profile data '${profileData.id}'");
      actualFirefoxProfileName = profileData.baseProfileName or profileData.profileName;
      browserPrettyName = browserInfo.prettyName or (strings.toUpper (substring 0 1 browserKey) + (substring 1 (-1) browserKey));
      desktopLauncherName = "${browserPrettyName} ${profileData.launcherNamePrefix}";
      internalName = "${nameSuffixProfile}-${profileData.id}-${browserKey}";
      logoKeyValue = profileData.logoKey or browserKey;
      logo = getLogo { logoKey = logoKeyValue; entryType = "profile"; };
      profileTypeString = desktopConstants.genericStrings.profileTypes.${profileData.genericNameKey} or profileData.launcherNamePrefix;
      genericName = "${desktopConstants.genericStrings.prefix.launcher or "Launcher"} - ${profileTypeString} ${desktopConstants.genericStrings.suffix.profile or "Profile"}";
      baseExec = "${browserInfo.pkg}/bin/${browserInfo.bin} -P \"${actualFirefoxProfileName}\"";
      additionalArgs = if profileData.execArgs != null then " " + (concatStringsSep " " profileData.execArgs) else "";
      finalExec = "${baseExec}${additionalArgs} ${browserInfo.newWindowArg or ""} %u";
    in
    pkgs.makeDesktopItem {
      name = internalName;
      desktopName = desktopLauncherName;
      inherit genericName;
      exec = finalExec;
      icon = logo;
      comment = profileData.comment or "Launch ${desktopLauncherName}";
      categories = profileData.categories or desktopConstants.defaultCategories.webBrowserProfile;
      type = "Application";
      terminal = false;
      mimeTypes = [ "text/html" "x-scheme-handler/http" "x-scheme-handler/https" ];
    };

  mkWebBookmarkEntry = bookmarkData:
    let
      browserInfo = desktopConstants.browserExecutables.${bookmarkData.browser or "firefox"} or desktopConstants.browserExecutables.firefox;
      internalName = "${nameSuffixBookmark}-${bookmarkData.idName}";
      desktopLauncherName = bookmarkData.siteName;
      logoKeyValue = bookmarkData.logoKey or (toLower (replaceStrings [ " " ] [ "-" ] bookmarkData.siteName));
      logo = getLogo { logoKey = logoKeyValue; entryType = "webBookmark"; };
      profileTypeString = desktopConstants.genericStrings.profileTypes.${bookmarkData.genericNameKey} or bookmarkData.siteName;
      genericName = "${desktopConstants.genericStrings.prefix.webApp or "Web App"} - ${profileTypeString} ${desktopConstants.genericStrings.suffix.bookmark or "Bookmark"}";
      execCmd =
        if bookmarkData.profileName == null then
          "${browserInfo.pkg}/bin/${browserInfo.bin} ${browserInfo.newWindowArg or ""} ${escapeShellArg bookmarkData.url}"
        else
          "${browserInfo.pkg}/bin/${browserInfo.bin} -P \"${bookmarkData.profileName}\" ${browserInfo.newWindowArg or ""} ${escapeShellArg bookmarkData.url}";
    in
    pkgs.makeDesktopItem {
      name = internalName;
      desktopName = desktopLauncherName;
      inherit genericName;
      exec = execCmd;
      icon = logo;
      comment = bookmarkData.comment or "Open ${bookmarkData.siteName}";
      categories = bookmarkData.categories or desktopConstants.defaultCategories.webBookmark;
      type = "Application";
      terminal = false;
      mimeTypes = [ "text/html" "x-scheme-handler/http" "x-scheme-handler/https" ];
    };

  mkApplicationLauncherEntry =
    { appName
    , appConfig
    , appPkgPath
    }:
    let
      desktopOverrides = appConfig.desktop or { };

      # --- Inference Engine ---
      # Name (internal .desktop file name)
      # Convention: appName (from module) + "-rhodium-desktop" or similar for uniqueness
      inferredName = "${toLower appName}-${nameSuffixApp}";
      finalName = desktopOverrides.withName or inferredName;

      # DesktopName (visible name, e.g., "Neovim")
      prettifyAppName = name: strings.toUpper (substring 0 1 name) + (substring 1 (-1) name);
      inferredDesktopName = prettifyAppName appName;
      finalDesktopName = desktopOverrides.withDesktopName or inferredDesktopName;

      # GenericName (Category like "Text Editor")
      pathParts = lib.splitString "." appPkgPath;
      inferredGenericName =
        if lib.length pathParts >= 2
        then prettifyAppName (lib.elemAt pathParts (lib.length pathParts - 2))
        else inferredDesktopName;
      finalGenericName = desktopOverrides.withGenericName or inferredGenericName;

      # Icon
      inferredIconKey = toLower appName;
      appActualPackage = appConfig.package or pkgs.${appName} or null;
      finalIcon = getLogo {
        logoKey = desktopOverrides.withIcon or inferredIconKey;
        inherit appActualPackage;
        entryType = "application";
      };

      # Exec command
      isTUIEditorConvention = (hasPrefix "rhodium.home.development.editors" appPkgPath && (elem appName [ "helix" "neovim" "micro" ]))
        || (hasPrefix "rhodium.home.apps.terminal.utils" appPkgPath && (elem appName [ "btop" "htop" ]));
      defaultTerminal = config.home.sessionVariables.TERMINAL or desktopConstants.defaultTerminalCommand or "${pkgs.kitty}/bin/kitty";
      homeDir = config.home.homeDirectory;
      inferredExec =
        if isTUIEditorConvention then "${defaultTerminal} --directory ${homeDir} ${appName} %F"
        else if hasPrefix "rhodium.home.apps.terminal.emulators" appPkgPath && appActualPackage != null then "${appActualPackage}/bin/${appName}"
        else if appActualPackage != null then "${appActualPackage}/bin/${appActualPackage.meta.mainProgram or appName}"
        else "echo 'Error: Exec command not configured for ${appName}'";
      finalExec = desktopOverrides.withExec or inferredExec;

      # Terminal
      inferredTerminal = isTUIEditorConvention || (lib.any (term -> lib.hasInfix term finalExec) [ "kitty" "alacritty" "wezterm" "foot" "gnome-terminal" ]);
      finalTerminal = desktopOverrides.withTerminal or inferredTerminal;

      # Categories
      defaultCategories =
        if hasPrefix "rhodium.home.development.editors" appPkgPath then desktopConstants.defaultCategories.textEditor
        else if hasPrefix "rhodium.home.apps.terminal.emulators" appPkgPath then desktopConstants.defaultCategories.terminalEmulator
        else desktopConstants.defaultCategories.app;
      finalCategories = desktopOverrides.withCategories or defaultCategories;

      # Comment
      defaultComment = "Launch ${finalDesktopName}";
      finalComment = desktopOverrides.withComment or defaultComment;

      # MimeTypes
      finalMimeTypes = desktopOverrides.withMimeTypes or [ ];

    in
    pkgs.makeDesktopItem {
      name = finalName;
      desktopName = finalDesktopName;
      genericName = finalGenericName;
      exec = finalExec;
      icon = finalIcon;
      comment = finalComment;
      categories = finalCategories;
      terminal = finalTerminal;
      type = "Application";
      mimeTypes = finalMimeTypes;
    };
}
