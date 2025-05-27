{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.assets;

  assetLinker = import ../../Lib/generators/assetLinker.nix { inherit config lib pkgs; };

in
{
  options.assets = {
    icons.enable = mkEnableOption "Link icons directory to XDG data home";
    wallpapers.enable = mkEnableOption "Link wallpapers directory to XDG data home";
    fonts.enable = mkEnableOption "Link fonts directory to XDG data home";

    # Optional: Allow custom source directory
    sourceDirectory = mkOption {
      type = types.str;
      default = "${config.home.homeDirectory}/assets";
      description = "Source directory containing asset folders";
    };
  };

  config = mkIf (cfg.icons.enable || cfg.wallpapers.enable || cfg.fonts.enable)
    (assetLinker.linkAssets {
      inherit (cfg) icons wallpapers fonts sourceDirectory;
    });
}
