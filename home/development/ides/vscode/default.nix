# home/development/ides/vscode/default.nix

{ lib, config ? null, pkgs ? null, _haumea ? null, rhodiumLib ? null }:

let
  # Generators
  themeGenerator = import ./themeGenerator.nix { inherit lib; };
  workspaceGenerator = import ./workspaceGenerator.nix { inherit lib config pkgs _haumea rhodiumLib; };

  # Base user settings
  baseUserSettings = lib.mkMerge [
    (import ./editor.nix)
    (import ./languages.nix)
    (import ./files.nix)
    (import ./extensions.nix)
  ];

  # Generate complete user settings
  generateUserSettings = globalConfig: lib.mkMerge [
    baseUserSettings

    # Global theme
    (themeGenerator.getThemeSettings (globalConfig.theme or rhodiumLib.defaults.themeDefaults.themeName))

    # Window title
    { "window.title" = "${rhodiumLib.defaults.nameDefaults.systemName.possessive} VS Code"; }

    # Spelling
    (lib.optionalAttrs (globalConfig.spelling.enable or false)
      (import ./dictionary.nix))
  ];
in
{
  inherit themeGenerator;
  inherit workspaceGenerator;
  inherit baseUserSettings;
  inherit generateUserSettings;

  generateWorkspaceFiles = globalConfig:
    if workspaceGenerator != null then
      let
        enabledWorkspaces = lib.filterAttrs
          (name: workspace: workspace.enable or false)
          (globalConfig.workspaces or { });
      in
      lib.mapAttrs'
        (workspaceName: workspaceConfig: {
          name = "vscode/${workspaceName}.code-workspace";
          value = {
            text = builtins.toJSON (
              workspaceGenerator.workspaceFileGenerator workspaceName workspaceConfig globalConfig
            );
          };
        })
        enabledWorkspaces
    else { };
}
