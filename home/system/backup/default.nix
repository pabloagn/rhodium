# home/system/backup/default.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  categoryName = _haumea.name;

  packageSpecs = [
    {
      name = "borgbackup";
      pkg = pkgs.borgbackup;
      description = "Deduplicating archiver with compression and authenticated encryption.";
    }
    {
      name = "borgmatic";
      pkg = pkgs.borgmatic;
      description = "Simple, config-driven backup for BorgBackup.";
    }
    {
      name = "kopia";
      pkg = pkgs.kopia;
      description = "Fast and secure open-source backup/restore tool (CLI).";
    }
    {
      name = "kopia-ui";
      pkg = pkgs.kopia-ui;
      description = "Desktop UI for Kopia backup/restore tool (GUI).";
    }
    {
      name = "rclone";
      pkg = pkgs.rclone;
      description = "Rsync for cloud storage. Syncs files and directories to and from different cloud storage providers.";
    }
    {
      name = "restic";
      pkg = pkgs.restic;
      description = "Fast, secure, efficient backup program.";
    }
    {
      name = "rsync";
      pkg = pkgs.rsync;
      description = "Fast, versatile, remote (and local) file-copying tool.";
    }
    {
      name = "syncthing";
      pkg = pkgs.syncthing;
      description = "Continuous file synchronization program.";
    }
    {
      name = "timeshift";
      pkg = pkgs.timeshift;
      description = "A system restore utility which takes snapshots of the system using rsync and BTRFS.";
    }
    {
      name = "vorta";
      pkg = pkgs.vorta;
      description = "Desktop GUI for BorgBackup.";
    }
    {
      name = "duplicity";
      pkg = pkgs.duplicity;
      description = "Encrypted bandwidth-efficient backup using rsync algorithm.";
    }
  ];
in
{
  options = setAttrByPath _haumea.configPath
    {
      enable = mkEnableOption "Rhodium's ${categoryName} configurations";
    } // rhodiumLib.mkIndividualPackageOptions packageSpecs;

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;
  };
}
