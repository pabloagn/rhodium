# home/environment/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.environment;
in
{
  imports = [
    ./mime.nix
    ./paths.nix
    ./variables.nix
  ];

  options.rhodium.home.environment = {
    enable = mkEnableOption "Rhodium's environment configuration";

    preferredApps = {
      browser = mkOption {
        type = types.nullOr types.str;
        default = "firefox";
        description = "Preferred web browser (executable name).";
        example = "brave";
      };

      editor = mkOption {
        type = types.nullOr types.str;
        default = "hx";
        description = "Preferred text editor (executable name).";
        example = "nvim";
      };

      terminal = mkOption {
        type = types.nullOr types.str;
        default = "ghostty";
        description = "Preferred terminal emulator (executable name).";
        example = "kitty";
      };

      imageViewer = mkOption {
        type = types.nullOr types.str;
        default = "feh";
        description = "Preferred image viewer (executable name).";
        example = "imv";
      };

      videoPlayer = mkOption {
        type = types.nullOr types.str;
        default = "mpv";
        description = "Preferred video player (executable name).";
      };

      audioPlayer = mkOption {
        type = types.nullOr types.str;
        default = "clementine";
        description = "Preferred audio player (executable name).";
      };

      pdfViewer = mkOption {
        type = types.nullOr types.str;
        default = "org.kde.okular.desktop";
        description = "Preferred PDF viewer (executable or .desktop file name for MIME).";
      };
    };
  };

  config = mkIf cfg.enable {
    rhodium.home.environment = {
      mime.enable = true;
      paths.enable = true;
      variables.enable = true;
    };
  };
}
