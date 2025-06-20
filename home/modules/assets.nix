{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.assets;
  repoAssetsPath = toString ../assets;
in {
  options.assets = {
    icons.enable = mkEnableOption "Link icons directory to XDG data home";
    wallpapers.enable = mkEnableOption "Link wallpapers directory to XDG data home";
    fonts.enable = mkEnableOption "Link fonts directory to fonts path";
  };

  config = mkMerge [
    # Use home-manager's file management for wallpapers
    (mkIf cfg.wallpapers.enable {
      xdg.dataFile."wallpapers" = {
        source = "${repoAssetsPath}/wallpapers";
        recursive = true;
        # Force symlink creation even if target exists
        force = true;
      };
    })

    # Use home-manager's file management for icons
    (mkIf cfg.icons.enable {
      xdg.dataFile."icons" = {
        source = "${repoAssetsPath}/icons";
        recursive = true;
        force = true;
      };
    })

    # Fonts still need special handling since they're not in XDG
    (mkIf cfg.fonts.enable {
      home.file.".local/share/fonts" = {
        source = "${repoAssetsPath}/fonts";
        recursive = true;
        force = true;
      };
    })

    # Optional: Add a verification activation script
    {
      home.activation.verify-assets = lib.hm.dag.entryAfter ["linkGeneration"] ''
        ${optionalString cfg.wallpapers.enable ''
          if [ -L "${config.xdg.dataHome}/wallpapers" ] && [ -e "${config.xdg.dataHome}/wallpapers" ]; then
            echo "✓ Wallpapers symlink verified"
          else
            echo "⚠ Wallpapers symlink missing or broken!"
          fi
        ''}
        ${optionalString cfg.icons.enable ''
          if [ -L "${config.xdg.dataHome}/icons" ] && [ -e "${config.xdg.dataHome}/icons" ]; then
            echo "✓ Icons symlink verified"
          else
            echo "⚠ Icons symlink missing or broken!"
          fi
        ''}
        ${optionalString cfg.fonts.enable ''
          if [ -L "${config.home.homeDirectory}/.local/share/fonts" ] && [ -e "${config.home.homeDirectory}/.local/share/fonts" ]; then
            echo "✓ Fonts symlink verified"
          else
            echo "⚠ Fonts symlink missing or broken!"
          fi
        ''}
      '';
    }
  ];
}

# {
#   lib,
#   config,
#   ...
# }:
# with lib; let
#   cfg = config.assets;
#   repoAssetsPath = toString ../assets;
# in {
#   options.assets = {
#     icons.enable = mkEnableOption "Link icons directory to XDG data home";
#     wallpapers.enable = mkEnableOption "Link wallpapers directory to XDG data home";
#     fonts.enable = mkEnableOption "Link fonts directory to fonts path";
#   };
#
#   config = {
#     # Direct activation scripts
#     home.activation.link-assets = lib.hm.dag.entryAfter ["writeBoundary"] ''
#       ${optionalString cfg.wallpapers.enable ''
#         echo "Setting up wallpapers symlink..."
#         $DRY_RUN_CMD mkdir -p "${config.xdg.dataHome}"
#         $DRY_RUN_CMD rm -rf "${config.xdg.dataHome}/wallpapers"
#         $DRY_RUN_CMD ln -sf "${repoAssetsPath}/wallpapers" "${config.xdg.dataHome}/wallpapers"
#         echo "✓ Wallpapers linked: ${config.xdg.dataHome}/wallpapers -> ${repoAssetsPath}/wallpapers"
#       ''}
#
#       ${optionalString cfg.icons.enable ''
#         echo "Setting up icons symlink..."
#         $DRY_RUN_CMD mkdir -p "${config.xdg.dataHome}"
#         $DRY_RUN_CMD rm -rf "${config.xdg.dataHome}/icons"
#         $DRY_RUN_CMD ln -sf "${repoAssetsPath}/icons" "${config.xdg.dataHome}/icons"
#         echo "✓ Icons linked: ${config.xdg.dataHome}/icons -> ${repoAssetsPath}/icons"
#       ''}
#
#       ${optionalString cfg.fonts.enable ''
#         echo "Setting up fonts symlink..."
#         $DRY_RUN_CMD mkdir -p "${config.home.homeDirectory}/.local/share"
#         $DRY_RUN_CMD rm -rf "${config.home.homeDirectory}/.local/share/fonts"
#         $DRY_RUN_CMD ln -sf "${repoAssetsPath}/fonts" "${config.home.homeDirectory}/.local/share/fonts"
#         echo "✓ Fonts linked: ${config.home.homeDirectory}/.local/share/fonts -> ${repoAssetsPath}/fonts"
#       ''}
#     '';
#   };
# }
