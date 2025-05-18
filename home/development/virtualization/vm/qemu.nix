# home/development/virtualization/vm/qemu.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.development.virtualization.vm.qemu;
in
{
  options.rhodium.development.virtualization.vm.qemu = {
    enable = mkEnableOption "Rhodium's QEMU configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      qemu
      kvmtools
    ];
  };
}
