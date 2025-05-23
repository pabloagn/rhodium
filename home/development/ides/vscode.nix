# home/development/ides/vscode.nix
{ lib, config, pkgs, pkgs-unstable, _haumea, rhodiumLib, ... }:

with lib;
let
  categoryName = _haumea.name;
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  configModule = ./vscode;

  vscodeLib = import configModule {
    inherit lib config pkgs _haumea rhodiumLib;
  };

  variantSpecs = {
    stable = {
      pkg = pkgs.vscode;
      description = "VS Code Stable: Standard release from 'pkgs'.";
    };
    insiders = {
      pkg = pkgs-unstable.vscode-insiders;
      description = "VS Code Insiders: Preview builds from 'pkgs-unstable'.";
    };
    vscodium = {
      pkg = pkgs.vscodium;
      description = "VSCodium: FOSS version without Microsoft branding from 'pkgs'.";
    };
  };

  userSettings = vscodeLib.generateUserSettings cfg;
  workspaceFiles = vscodeLib.generateWorkspaceFiles cfg;

in
{
  options = setAttrByPath _haumea.configPath (
    rhodiumLib.mkAppModuleOptions
      {
        appName = categoryName;
        hasDesktop = true;
        defaultEnable = false;
      }
    //
    lib.mapAttrs
      (variantName: spec: {
        enable = mkEnableOption spec.description // { default = false; };
      })
      variantSpecs
    //
    {
      # Global theme selection
      theme = mkOption {
        type = types.enum [ "tokyo-night" "catppuccin-mocha" ];
        default = "tokyo-night";
        description = "Global theme for VS Code (applies to user settings and workspaces unless overridden)";
      };

      # Spelling configuration
      spelling = {
        enable = mkEnableOption "spelling and dictionary support";

        globalDictionary = mkOption {
          type = types.listOf types.str;
          default = [];
          description = "Additional words to add to global dictionary";
        };
      };

      # Workspace management
      workspaces = mkOption {
        type = types.attrsOf (types.submodule {
          options = {
            enable = mkEnableOption "this workspace template";

            theme = mkOption {
              type = types.nullOr (types.enum [ "tokyo-night" "catppuccin-mocha" ]);
              default = null;
              description = "Override global theme for this workspace";
            };

            spelling = {
              enable = mkOption {
                type = types.nullOr types.bool;
                default = null;
                description = "Override global spelling setting for this workspace";
              };
            };

            folders = mkOption {
              type = types.listOf (types.attrsOf types.str);
              default = [];
              description = "Workspace folder definitions";
            };

            extensions = mkOption {
              type = types.listOf types.str;
              default = [];
              description = "Recommended extensions for this workspace";
            };

            extraSettings = mkOption {
              type = types.attrs;
              default = {};
              description = "Additional workspace-specific settings";
            };
          };
        });
        default = {};
        description = "Workspace template definitions";
      };
    }
  );

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    # Install selected VS Code variants
    home.packages = lib.flatten (
      lib.mapAttrsToList
        (variantName: spec:
          lib.optional (cfg.${variantName}.enable or false) spec.pkg
        )
        variantSpecs
    );

    programs.vscode = lib.mkIf (cfg.enable && (cfg.stable.enable or cfg.insiders.enable or cfg.vscodium.enable)) {
      enable = true;
      userSettings = userSettings;
    };

    # Workspace file generator
    xdg.configFile = lib.mkMerge [
      (lib.mkIf (cfg.workspaces != {} && (builtins.length (builtins.attrNames workspaceFiles) > 0))
        workspaceFiles)

      # Legacy static files
      # TODO: Remove
      # (lib.mkIf (cfg.enable && (cfg.stable.enable or cfg.insiders.enable or cfg.vscodium.enable)) {
      #   "vscode/settings.json" = { source = ./vscode/settings.json; };
      #   "vscode/extensions.json" = { source = ./vscode/extensions.json; };
      # })
    ];
  };
}
