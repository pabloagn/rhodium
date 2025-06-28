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
    ascii.enable = mkEnableOption "Link ascii directory to XDG data home";
    wallpapers.enable = mkEnableOption "Link wallpapers directory to XDG data home";
    fonts.enable = mkEnableOption "Link fonts directory to fonts path";
    colors.enable = mkEnableOption "Link color palette files to XDG data home";
  };

  config = mkMerge [
    # Color Packs
    (mkIf cfg.colors.enable {
      xdg.dataFile."colors" = {
        source = "${repoAssetsPath}/colors";
        recursive = true;
        force = true;
      };
    })

    # Wallpaper Packs
    (mkIf cfg.wallpapers.enable {
      xdg.dataFile."wallpapers" = {
        source = "${repoAssetsPath}/wallpapers";
        recursive = true;
        # Force symlink creation even if target exists
        force = true;
      };
    })

    # Icon Packs
    (mkIf cfg.icons.enable {
      xdg.dataFile."icons" = {
        source = "${repoAssetsPath}/icons";
        recursive = true;
        force = true;
      };
    })

    # Font Packs
    (mkIf cfg.fonts.enable {
      home.file.".local/share/fonts" = {
        source = "${repoAssetsPath}/fonts";
        recursive = true;
        force = true;
      };
    })

    # ASCII art
    (mkIf cfg.icons.enable {
      xdg.dataFile."ascii" = {
        source = "${repoAssetsPath}/ascii";
        recursive = true;
        force = true;
      };
    })

    # Verification activation script
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
        ${optionalString cfg.ascii.enable ''
          if [ -L "${config.xdg.dataHome}/ascii" ] && [ -e "${config.xdg.dataHome}/ascii" ]; then
            echo "✓ ASCII symlink verified"
          else
            echo "⚠ ASCII symlink missing or broken!"
          fi
        ''}
        ${optionalString cfg.fonts.enable ''
          if [ -L "${config.home.homeDirectory}/.local/share/fonts" ] && [ -e "${config.home.homeDirectory}/.local/share/fonts" ]; then
            echo "✓ Fonts symlink verified"
          else
            echo "⚠ Fonts symlink missing or broken!"
          fi
        ''}
        ${optionalString cfg.colors.enable ''
          if [ -L "${config.xdg.dataHome}/colors" ] && [ -e "${config.xdg.dataHome}/colors" ]; then
            echo "✓ Colors symlink verified"
          else
            echo "⚠ Colors symlink missing or broken!"
          fi
        ''}
      '';
    }
  ];
}
