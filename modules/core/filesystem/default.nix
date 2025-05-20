# modules/core/filesystem/default.nix

{ config, lib, pkgs, hostData, ... }:

with lib;
let
  cfg = config.rhodium.system.core.filesystem;
in
{
  options.rhodium.system.core.filesystem = {
    enable = mkEnableOption "Rhodium filesystem configuration";

    mounts = mkOption {
      type = types.attrsOf (types.submodule ({ ... }: {
        options = {
          device = mkOption { type = types.nullOr types.str; default = null; };
          fsType = mkOption { type = types.nullOr types.str; default = null; };
          options = mkOption { type = types.listOf types.str; default = [ ]; };
        };
      }));
      default = { };
      description = ''
        Attribute set defining file systems to mount.
        This should generally be populated from hostData.fileSystems.
        Example: { "/" = { device = "/dev/sda1"; fsType = "ext4"; }; }
      '';
    };

    swaps = mkOption {
      type = types.listOf (types.submodule ({ ... }: {
        options = {
          device = mkOption { type = types.nullOr types.str; default = null; };
          priority = mkOption { type = types.nullOr types.int; default = null; };
        };
      }));
      default = [ ];
      description = ''
        List of attribute sets defining swap devices.
        This should generally be populated from hostData.swapDevices.
        Example: [ { device = "/dev/sda2"; } ]
      '';
    };
  };

  config = mkIf cfg.enable {
    fileSystems = cfg.mounts;
    swapDevices = cfg.swaps;
  };
}
