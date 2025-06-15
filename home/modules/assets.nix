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

  config = {
    # Direct activation scripts
    home.activation.link-assets = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ${optionalString cfg.wallpapers.enable ''
        echo "Setting up wallpapers symlink..."
        $DRY_RUN_CMD mkdir -p "${config.xdg.dataHome}"
        $DRY_RUN_CMD rm -rf "${config.xdg.dataHome}/wallpapers"
        $DRY_RUN_CMD ln -sf "${repoAssetsPath}/wallpapers" "${config.xdg.dataHome}/wallpapers"
        echo "✓ Wallpapers linked: ${config.xdg.dataHome}/wallpapers -> ${repoAssetsPath}/wallpapers"
      ''}

      ${optionalString cfg.icons.enable ''
        echo "Setting up icons symlink..."
        $DRY_RUN_CMD mkdir -p "${config.xdg.dataHome}"
        $DRY_RUN_CMD rm -rf "${config.xdg.dataHome}/icons"
        $DRY_RUN_CMD ln -sf "${repoAssetsPath}/icons" "${config.xdg.dataHome}/icons"
        echo "✓ Icons linked: ${config.xdg.dataHome}/icons -> ${repoAssetsPath}/icons"
      ''}

      ${optionalString cfg.fonts.enable ''
        echo "Setting up fonts symlink..."
        $DRY_RUN_CMD mkdir -p "${config.home.homeDirectory}/.local/share"
        $DRY_RUN_CMD rm -rf "${config.home.homeDirectory}/.local/share/fonts"
        $DRY_RUN_CMD ln -sf "${repoAssetsPath}/fonts" "${config.home.homeDirectory}/.local/share/fonts"
        echo "✓ Fonts linked: ${config.home.homeDirectory}/.local/share/fonts -> ${repoAssetsPath}/fonts"
      ''}
    '';
  };
}
