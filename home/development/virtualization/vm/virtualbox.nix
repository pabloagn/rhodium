# home/development/virtualization/vm/virtualbox.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.development.virtualization.vm.virtualbox;
in
{
  options.rhodium.development.virtualization.vm.virtualbox = {
    enable = mkEnableOption "Rhodium's VirtualBox configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      virtualbox
    ];
  };
}
