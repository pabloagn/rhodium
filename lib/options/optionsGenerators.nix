# lib/options/optionsGenerators.nix

/*
  This file contains the options generators for the flake.
*/

{ lib }:

let
  mkIndividualPackageOptions = specs:
    /*
      Generates NixOS module options for a list of package specifications.
      Each spec can define an 'enable' option and, if 'variants' are provided,
      a 'variant' selection option.

      Type:
        mkIndividualPackageOptions :: [PackageSpec] -> AttrSetOf (NixOSOption)

      PackageSpec attributes:
        name: String (package identifier, used for option name)
        description: String (for mkEnableOption)
        default: Bool (optional, default for 'enable', defaults to false)
        variants: AttrSetOf (PackageDerivation | (AttrSet -> PackageDerivation)) (optional, map of variant names to packages/package functions)
        defaultVariant: String (optional, key from 'variants' to be the default)
        variantDescription: String (optional, description for the 'variant' option)
    */
    lib.listToAttrs (lib.map
      (spec:
        let
          packageOptions = {
            enable = lib.mkEnableOption spec.description // { default = spec.default or false; };
          };
          variantOptions =
            if spec.variants != null && builtins.attrNames spec.variants != [ ] then {
              variant = lib.mkOption {
                type = lib.types.enum (builtins.attrNames spec.variants);
                default = spec.defaultVariant or (lib.elemAt (builtins.attrNames spec.variants) 0);
                description = spec.variantDescription or "Select the package variant for ${spec.name}.";
              };
            } else { };
        in
        lib.nameValuePair spec.name (packageOptions // variantOptions)
      )
      specs);

  getEnabledPackages = cfg: specs: pkgsScope:
    /*
      Collects package derivations from specifications based on whether they are enabled
      and which variant (if any) is selected in the configuration.

      Type:
        getEnabledPackages :: Config -> [PackageSpec] -> PkgsScope -> [PackageDerivation]

      Args:
        cfg: The configuration attribute set for the module (e.g., config.rhodium.home.apps.category).
        specs: The list of package specifications (same as for mkIndividualPackageOptions).
        pkgsScope: An attribute set containing package sources (e.g., { pkgs, pkgs-unstable }).
                  This is passed to variant functions if they exist.
    */
    lib.concatMap
      (spec:
        if cfg.${spec.name}.enable then
          let
            selectedPkg =
              if spec.variants != null && builtins.attrNames spec.variants != [ ] && cfg.${spec.name} ? "variant" then
                let
                  variantName = cfg.${spec.name}.variant;
                  variantValue = spec.variants.${variantName};
                in
                if builtins.isFunction variantValue then variantValue pkgsScope else variantValue
              else
                spec.pkg;

            finalPkgs =
              if selectedPkg == null then
                [ ]
              else if builtins.isList selectedPkg then
                selectedPkg
              else
                [ selectedPkg ];
          in
          finalPkgs
        else [ ]
      )
      specs;

  mkChildConfig = parentCfg: childCfg: configValue:
    /*
      A helper to conditionally apply a configuration block based on the 'enable'
      status of both a parent and a child module configuration.

      Type:
        mkChildConfig :: ParentConfig -> ChildConfig -> ConfigValue -> ConfigValue

      Args:
        parentCfg: Configuration attribute set of the parent module (must have an 'enable' boolean option).
        childCfg: Configuration attribute set of the child module (must have an 'enable' boolean option).
        configValue: The NixOS configuration to be conditionally applied.
    */
    lib.mkIf (parentCfg.enable && childCfg.enable) configValue;

  mkAppModuleOptions =
    { appName
    , appDescription ? null
    , defaultEnable ? false
    , hasDesktop ? false
    }:
    /*
      Generates a standard set of NixOS module options for an application module.
      Includes an 'enable' option and optionally a nested 'desktop' attribute set
      for .desktop file customization.

      Type:
        mkAppModuleOptions :: {
          appName: String,
          appDescription: String (optional),
          defaultEnable: Bool (optional, defaults to false),
          hasDesktop: Bool (optional, defaults to false)
        } -> AttrSetOf (NixOSOption)
    */
    let
      prettifyAppName = name: lib.strings.toUpper (lib.substring 0 1 name) + (lib.substring 1 (-1) name);

      prettyAppName = prettifyAppName appName;

      finalModuleEnableDescription =
        if appDescription != null then appDescription
        else "Enable and configure the ${prettyAppName} module";

      desktopOptions =
        if hasDesktop then {
          desktop = {
            enable = lib.mkEnableOption "Generate .desktop file for ${prettyAppName}" // { default = false; };

            withName = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "Override the internal 'name' field of the .desktop file.";
            };

            withDesktopName = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "Override the 'DesktopName' (visible name).";
            };

            withGenericName = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "Override the 'GenericName'.";
            };

            withExec = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "Override the 'Exec' command.";
            };

            withIcon = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "Override the 'Icon' (logo key or path).";
            };

            withComment = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "Override the 'Comment' for the .desktop file.";
            };

            withCategories = lib.mkOption {
              type = lib.types.nullOr (lib.types.listOf lib.types.str);
              default = null;
              description = "Override 'Categories'.";
            };

            withTerminal = lib.mkOption {
              type = lib.types.nullOr lib.types.bool;
              default = null;
              description = "Override 'Terminal'.";
            };

            withMimeTypes = lib.mkOption {
              type = lib.types.nullOr (lib.types.listOf lib.types.str);
              default = null;
              description = "Override 'MimeType'.";
            };
          };
        } else { };
    in
    {
      enable = lib.mkEnableOption finalModuleEnableDescription // { default = defaultEnable; };
    } // desktopOptions;

in
{
  inherit mkIndividualPackageOptions getEnabledPackages mkChildConfig mkAppModuleOptions;
}
