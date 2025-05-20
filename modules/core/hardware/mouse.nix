# modules/core/hardware/mouse.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.system.hardware.mouse;
in
{
  options.rhodium.system.hardware.mouse = {
    enable = mkEnableOption "Rhodium mouse utility configuration";

    package.solaar = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to install Solaar for Logitech Unifying/Bolt receivers.";
    };

    package.piper = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to install Piper for configuring gaming mice (primarily Logitech G).";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages =
      (optional cfg.package.solaar pkgs.solaar)
      ++ (optional cfg.package.piper pkgs.piper);
  };
}
