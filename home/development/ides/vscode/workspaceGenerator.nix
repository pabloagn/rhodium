# home/development/ides/vscode/workspaceGenerator.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

let
  themeGenerator = import ./themeGenerator.nix { inherit lib; };

  # Base workspace settings
  baseWorkspaceSettings = {
    # Window settings
    "window.title" = "\${workspaceFolderBasename} - ${rhodiumLib.defaults.nameDefaults.systemName.pretty}";

    # Basic workspace behavior
    "workbench.editor.decorations.colors" = true;
    "workbench.editor.decorations.badges" = true;
    "workbench.editor.labelFormat" = "short";
    "workbench.editor.limit.enabled" = true;
    "workbench.editor.limit.value" = 15;
    "workbench.tree.indent" = 20;
    "workbench.tree.renderIndentGuides" = "always";
    "workbench.panel.defaultLocation" = "bottom";
    "workbench.activityBar.location" = "top";

    # Explorer
    "explorer.compactFolders" = true;
    "explorer.confirmDelete" = false;
    "explorer.confirmDragAndDrop" = false;

    # Problems
    "problems.autoReveal" = true;
    "problems.showCurrentInStatus" = true;
  };

  # Spell checker
  workspaceSpellingSettings = workspaceName: {
    "cSpell.customDictionaries" = {
      "project-dictionary" = {
        "name" = "project-dictionary";
        "path" = "\${workspaceFolder}/.vscode/${rhodiumLib.defaults.nameDefaults.dictionaryName}.txt";
        "addWords" = true;
        "scope" = "workspace";
      };
      "rhodium-${workspaceName}" = {
        "name" = "${rhodiumLib.defaults.nameDefaults.systemName.lower}-${workspaceName}";
        "path" = "\${workspaceFolder}/.rhodium/dictionaries/${workspaceName}.txt";
        "addWords" = true;
        "scope" = "workspace";
      };
    };
    "cSpell.dictionaries" = [ "project-dictionary" "${rhodiumLib.defaults.nameDefaults.systemName.lower}-${workspaceName}" ];
  };

  # Generate workspace settings
  generateWorkspaceSettings = workspaceName: workspaceConfig: globalConfig:
    let
      # Determine which theme to use (workspace override or global)
      effectiveTheme = workspaceConfig.theme or globalConfig.theme or rhodiumLib.defaults.theme;

      # Get theme settings
      themeSettings = themeGenerator.getThemeSettings effectiveTheme;

      # Get spelling settings if enabled
      spellingSettings = lib.optionalAttrs
        (workspaceConfig.spelling.enable or globalConfig.spelling.enable or false)
        (workspaceSpellingSettings workspaceName);

      # Merge all settings with proper precedence
    in lib.mkMerge [
      baseWorkspaceSettings
      themeSettings
      spellingSettings
      (workspaceConfig.extraSettings or {})
    ];

  # Function to generate workspace folder structure
  generateWorkspaceFolders = workspaceName: workspaceConfig:
    let
      defaultFolders = [
        {
          name = workspaceName;
          path = ".";
        }
      ];
    in workspaceConfig.folders or defaultFolders;

  # Function to generate complete workspace file
  generateWorkspaceFile = workspaceName: workspaceConfig: globalConfig:
    let
      settings = generateWorkspaceSettings workspaceName workspaceConfig globalConfig;
      folders = generateWorkspaceFolders workspaceName workspaceConfig;
      extensions = workspaceConfig.extensions or [];
    in {
      folders = folders;
      settings = settings;
      extensions = {
        recommendations = extensions;
      };
    };

in
{
  inherit generateWorkspaceFile generateWorkspaceSettings;

  # Export for use in main module
  workspaceFileGenerator = generateWorkspaceFile;
}
