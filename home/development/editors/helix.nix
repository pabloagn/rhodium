# home/development/editors/helix.nix
# Updated to integrate with rhodium theme system

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  categoryName = _haumea.name;
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;

  helixConfig = import ./helix { inherit config lib pkgs rhodiumLib; }; # Pass rhodiumLib

  # Profiles
  profiles = {
    developer = helixConfig.profiles.developer;
    minimal = helixConfig.profiles.minimal;
    writer = helixConfig.profiles.writer;
  };

  # Get the selected profile or default
  selectedProfile = profiles.${cfg.profile or "developer"};

  # Enhanced theme files generation with rhodium theme support
  themeFiles =
    let
      themes = helixConfig.themeConfig.themes;
      variants = helixConfig.themeConfig.variants;
      allThemes = themes // variants;

      # Check if the selected theme is a rhodium theme
      isRhodiumTheme = themeName:
        builtins.elem themeName [ "phantom" "ghost" "minimal" "ecstatic" "modernist" "symbolist" "abstract" ];

      # Get theme configuration - either from helix config or rhodium system
      getThemeConfig = themeName:
        if allThemes ? ${themeName} then
        # Use theme from helix config
          allThemes.${themeName}
        else if isRhodiumTheme themeName then
        # Generate theme from rhodium system
          let
            resolvedTheme = rhodiumLib.theme.resolveTheme themeName;
            helixThemeGen = helixConfig.themeConfig.generateHelixThemeFromRhodium or null;
          in
          if helixThemeGen != null then
            helixThemeGen themeName
          else
            throw "Rhodium theme generator not available in helix config"
        else
          throw "Theme '${themeName}' not found in helix themes or rhodium themes";

    in
    builtins.listToAttrs (
      map
        (themeName: {
          name = "helix/themes/${themeName}.toml";
          value = {
            text = generators.toTOML { } (getThemeConfig themeName);
          };
        })
        # Include all themes from helix config plus any rhodium themes that might be referenced
        (builtins.attrNames allThemes ++
          (if cfg.customTheme != null && isRhodiumTheme cfg.customTheme && !(allThemes ? ${cfg.customTheme})
          then [ cfg.customTheme ]
          else [ ]))
    );

  # Generate languages configuration
  languagesFile = generators.toTOML { } helixConfig.languagesConfig.all;

in
{
  options = setAttrByPath _haumea.configPath (
    rhodiumLib.mkAppModuleOptions
      {
        appName = categoryName;
        hasDesktop = true;
      } // {
      profile = mkOption {
        type = types.enum [ "developer" "minimal" "writer" ];
        default = "developer";
        description = "Helix configuration profile";
      };

      customTheme = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Custom theme name to use (supports both helix and rhodium themes)";
      };

      extraConfig = mkOption {
        type = types.attrs;
        default = { };
        description = "Extra configuration to merge with the selected profile";
      };

      enabledLanguages = mkOption {
        type = types.either (types.enum [ "all" "minimal" ]) (types.listOf types.str);
        default = "all";
        description = "Languages to enable support for";
      };

      keyProfile = mkOption {
        type = types.enum [ "vim" "vscode" "emacs" "minimal" ];
        default = "vim";
        description = "Key mapping profile to use";
      };
    }
  );

  config = mkIf cfg.enable (
    rhodiumLib.mkChildConfig parentCfg cfg {
      programs.helix = {
        enable = true;
        package = pkgs.helix;

        # Generate the configuration dynamically
        settings =
          let
            baseConfig = selectedProfile;
            customKeys = helixConfig.keysConfig.profiles.${cfg.keyProfile or "vim"};
            languageConfig =
              if cfg.enabledLanguages == "all" then helixConfig.languagesConfig.all
              else if cfg.enabledLanguages == "minimal" then helixConfig.languagesConfig.minimal
              else helixConfig.languagesConfig.filterByNames cfg.enabledLanguages;

            selectedThemeName = cfg.customTheme or baseConfig.theme or "phantom";
            resolvedTheme =
              if isRhodiumTheme selectedThemeName then
                rhodiumLib.theme.resolveTheme selectedThemeName
              else null;

            finalConfig = recursiveUpdate baseConfig (cfg.extraConfig // {
              keys = customKeys;
              theme = selectedThemeName;
            } // (if resolvedTheme != null then {
              editor = (cfg.extraConfig.editor or { }) // {
                font-family = resolvedTheme.fonts.mono.family;
              };
            } else { }));
          in
          finalConfig;

        # Languages configuration
        languages =
          if cfg.enabledLanguages == "all" then helixConfig.languagesConfig.all
          else if cfg.enabledLanguages == "minimal" then helixConfig.languagesConfig.minimal
          else helixConfig.languagesConfig.filterByNames cfg.enabledLanguages;
      };

      # Generate configuration files dynamically
      xdg.configFile = themeFiles // {
        # Generate languages.toml from Nix configuration
        "helix/languages.toml".text = languagesFile;
      };

      # Conditional servers and formatters
      home.packages = with pkgs;
        optionals (cfg.enabledLanguages != "minimal") [
          # Language servers (only if available)
        ] ++ optionals
          (elem "rust" (
            if builtins.isList cfg.enabledLanguages
            then cfg.enabledLanguages
            else [ ]
          )) [
          rust-analyzer
          rustfmt
        ] ++ optionals
          (elem "nix" (
            if builtins.isList cfg.enabledLanguages
            then cfg.enabledLanguages
            else [ "nix" ] # Always!
          )) [
          nil
          nixpkgs-fmt
        ] ++ optionals
          (elem "python" (
            if builtins.isList cfg.enabledLanguages
            then cfg.enabledLanguages
            else [ ]
          )) [
          pyright
          ruff
        ];
    }
  );
}
