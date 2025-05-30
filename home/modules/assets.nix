{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.assets;

  repoAssetsPath = toString (../assets);

  mkAssetLink = enable: targetPath: sourceSubdir:
    mkIf enable {
      home.file."${targetPath}".source =
        config.lib.file.mkOutOfStoreSymlink "${repoAssetsPath}/${sourceSubdir}";
    };
in
{
  options.assets = {
    icons.enable = mkEnableOption "Link icons directory to XDG data home";
    wallpapers.enable = mkEnableOption "Link wallpapers directory to XDG data home";
    fonts.enable = mkEnableOption "Link fonts directory to fonts path";
  };

  config = mkMerge [
    (mkAssetLink cfg.icons.enable "${config.xdg.dataHome}/icons" "icons")
    (mkAssetLink cfg.wallpapers.enable "${config.xdg.dataHome}/wallpapers" "wallpapers")
    (mkAssetLink cfg.fonts.enable "${config.home.homeDirectory}/.local/share/fonts" "fonts")
  ];
}
