# home/apps/terminal/utils/compression/default.nix

{ config, lib, pkgs, rhodium, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.terminal.utils.compression;
  categoryName = "compression";

  packageSpecs = [
    { name = "zip"; pkg = pkgs.zip; description = "Legacy zip format"; }
    { name = "unzip"; pkg = pkgs.unzip; description = "Extract zip archives"; }
    { name = "unrar"; pkg = pkgs.unrar; description = "RAR archive utility"; }
    { name = "p7zip"; pkg = pkgs.p7zip; description = "7z archive utility"; }
    { name = "zstd"; pkg = pkgs.zstd; description = "Zstandard compression (modern, fast)"; }
    { name = "gzip"; pkg = pkgs.gzip; description = "GNU zip compression"; }
    { name = "bzip2"; pkg = pkgs.bzip2; description = "Block-sorting compression"; }
    { name = "xz"; pkg = pkgs.xz; description = "XZ Utils compression (high ratio)"; }
  ];
in
{
  options.rhodium.home.apps.terminal.utils.${categoryName} = {
    enable = mkEnableOption "Rhodium's ${categoryName} terminal utils";
  } // rhodium.lib.mkIndividualPackageOptions packageSpecs;

  config = mkIf cfg.enable {
    home.packages = rhodium.lib.getEnabledPackages cfg packageSpecs;
  };
}
