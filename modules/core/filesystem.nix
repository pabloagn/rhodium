# modules/core/hardware/filesystem.nix

{ config, lib, ... }:

{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/a729d1fd-92c8-4803-9f4b-a3ee9aee5aac";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/EFAB-C786";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices = [{ device = "/dev/disk/by-uuid/5d21ee96-9219-40e1-b665-f26c580b19b7"; }];
}
