{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.scripts;

  scriptLinker = import ../../lib/generators/scriptLinker.nix { inherit config lib pkgs; };

in
{
  options.scripts = {
    enable = mkEnableOption "Link scripts directory to local bin path";

    # Optional: Allow custom source directory
    sourceDirectory = mkOption {
      type = types.str;
      default = "${config.home.homeDirectory}";
      description = "Source directory containing scripts folder";
    };
  };

  config = mkIf cfg.enable
    (scriptLinker.linkScripts {
      inherit (cfg) enable sourceDirectory;
    });
}
