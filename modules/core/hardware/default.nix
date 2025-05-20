# modules/core/hardware/default.nix

{ lib, pkgs, config, modulesPath, userData, hostData, ... }:

with lib;

let
  cfg = config.rhodium.system.hardware;
in
{
  imports = [
    ./cpu.nix
    ./audio.nix
    ./bluetooth.nix
    ./keyboard.nix
    ./mouse.nix
    ./printers.nix
    ./video.nix
    ./extra.nix
  ];

  options.rhodium.system.hardware = {
    enable = mkEnableOption "Rhodium hardware configuration";
  };

  config = mkIf cfg.enable {
    rhodium.system.hardware.keyboard = {
      enable = true;
      applyHostSettings = true;
    };
  };
}
