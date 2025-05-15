# /home/modules/linker.nix

{ config, lib, pkgs, flakeOutputs, ... }:

let
  cfg = config.rhodium.linker;
  flakeRootInStore = flakeOutputs.self;
in
{
  options.rhodium.linker = {
    enable = lib.mkEnableOption "Rhodium central symlinking service";

    sharedDirs = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "symlinking this shared directory";
          flakePath = lib.mkOption { type = lib.types.str; };
          targetPath = lib.mkOption { type = lib.types.str; };
        };
      });
      default = { };
    };

    moduleConfigs = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "symlinking configuration files for this module";
          files = lib.mkOption {
            type = lib.types.attrsOf (lib.types.submodule {
              options = {
                enable = lib.mkEnableOption "symlinking this specific file";
                source = lib.mkOption { type = lib.types.path; };
              };
            });
            default = { };
          };
        };
      });
      default = { };
    };

    paths.shared = lib.mkOption { type = lib.types.attrsOf lib.types.path; readOnly = true; internal = true; };
    paths.moduleConfigs = lib.mkOption { type = lib.types.attrsOf (lib.types.attrsOf lib.types.path); readOnly = true; internal = true; };
  };

  config = lib.mkIf cfg.enable {
    home.symlinks =
      (lib.mapAttrs'
        (name: entry: lib.nameValuePair entry.targetPath { target = "${flakeRootInStore}/${entry.flakePath}"; })
        (lib.filterAttrs (name: entry: entry.enable) cfg.sharedDirs)
      )
      //
      (lib.foldlAttrs
        (finalLinksAcc: moduleName: moduleEntry:
          finalLinksAcc // lib.optionalAttrs moduleEntry.enable (
            lib.mapAttrs'
              (targetFileInXdg: fileEntry:
                lib.nameValuePair ".config/${targetFileInXdg}" { target = toString fileEntry.source; }
              )
              (lib.filterAttrs (name: fileEntry: fileEntry.enable) moduleEntry.files)
          )
        )
        { }
        cfg.moduleConfigs
      );

    rhodium.linker.paths.shared = lib.mapAttrs
      (name: entry: "${config.home.homeDirectory}/${entry.targetPath}")
      (lib.filterAttrs (name: entry: entry.enable) cfg.sharedDirs);

    rhodium.linker.paths.moduleConfigs = lib.mapAttrs
      (moduleName: moduleEntry:
        lib.optionalAttrs moduleEntry.enable (
          lib.mapAttrs
            (targetFileInXdg: fileEntry: "${config.xdg.configHome}/${targetFileInXdg}")
            (lib.filterAttrs (name: fileEntry: fileEntry.enable) moduleEntry.files)
        )
      )
      cfg.moduleConfigs;
  };
}
