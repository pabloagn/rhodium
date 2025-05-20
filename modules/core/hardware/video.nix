# modules/core/hardware/video.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.system.hardware.video;
in
{
  options.rhodium.system.hardware.video = {
    enable = mkEnableOption "Rhodium video utility configuration";

    package.brightnessctl = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to install brightnessctl for controlling screen brightness.";
    };

    package.ddcutil = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to install ddcutil for controlling external monitor settings via DDC/CI.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages =
      (optional cfg.package.brightnessctl pkgs.brightnessctl)
      ++ (optional cfg.package.ddcutil pkgs.ddcutil);
  };
}
