# modules/core/hardware/keyboard.nix

{ config, lib, pkgs, hostData, ... }:

with lib;
let
  cfg = config.rhodium.system.hardware.keyboard;
in
{
  options.rhodium.system.hardware.keyboard = {
    enable = mkEnableOption "Rhodium keyboard and localization configuration";

    package.xev = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to install xorg.xev for keyboard event debugging.";
    };

    applyHostSettings = mkOption {
      type = types.bool;
      default = true;
      description = "Whether this module should apply timeZone, locale, keyMap, and XKB layout from hostData.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = optional cfg.package.xev pkgs.xorg.xev;

    time.timeZone = mkIf cfg.applyHostSettings hostData.timeZone;
    i18n.defaultLocale = mkIf cfg.applyHostSettings hostData.locale;

    i18n.extraLocaleSettings = mkIf cfg.applyHostSettings {
      LC_ADDRESS = hostData.locale;
      LC_IDENTIFICATION = hostData.locale;
      LC_MEASUREMENT = hostData.locale;
      LC_MONETARY = hostData.locale;
      LC_NAME = hostData.locale;
      LC_NUMERIC = hostData.locale;
      LC_PAPER = hostData.locale;
      LC_TELEPHONE = hostData.locale;
      LC_TIME = hostData.locale;
    };

    console.keyMap = mkIf cfg.applyHostSettings hostData.keymap;

    services.xserver.xkb = mkIf cfg.applyHostSettings {
      layout = hostData.keyboardLayout;
      variant = hostData.keyboardVariant;
    };
  };
}
