{ config, lib, pkgs, ... }:

let
  pathGenerators = import ./pathGenerators.nix { inherit config lib pkgs; };
in
{
  linkAssets = { icons, wallpapers, fonts, sourceDirectory }:
    let
      assetsDir = sourceDirectory;
    in
    lib.mkMerge [
      (lib.mkIf icons.enable {
        home.file."${pathGenerators.xdgDataPaths.icons}".source =
          config.lib.file.mkOutOfStoreSymlink "${assetsDir}/icons";
      })

      (lib.mkIf wallpapers.enable {
        home.file."${pathGenerators.xdgDataPaths.wallpapers}".source =
          config.lib.file.mkOutOfStoreSymlink "${assetsDir}/wallpapers";
      })

      (lib.mkIf fonts.enable {
        home.file."${pathGenerators.fontPaths.user}".source =
          config.lib.file.mkOutOfStoreSymlink "${assetsDir}/fonts";
      })

      # Ensure parent directories exist when any asset linking is enabled
      (lib.mkIf (icons.enable || wallpapers.enable || fonts.enable) {
        home.activation.create-asset-parent-dirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          ${lib.optionalString icons.enable ''mkdir -p "$(dirname "${pathGenerators.xdgDataPaths.icons}")"''}
          ${lib.optionalString wallpapers.enable ''mkdir -p "$(dirname "${pathGenerators.xdgDataPaths.wallpapers}")"''}
          ${lib.optionalString fonts.enable ''mkdir -p "$(dirname "${pathGenerators.fontPaths.user}")"''}
        '';
      })
    ];
}
