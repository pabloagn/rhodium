# home/development/virtualization/vm/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.development.virtualization.vm;
in
{
  imports = [
    ./virtualbox.nix
    ./qemu.nix
  ];

  options.rhodium.development.virtualization.vm = {
    enable = mkEnableOption "Rhodium's VM tools";
  };

  config = mkIf cfg.enable {
    home.development.virtualization.vm.virtualbox.enable = true;
    home.development.virtualization.vm.qemu.enable = true;
  };
}
