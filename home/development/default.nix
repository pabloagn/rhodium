# home/development/default.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.development;
in

{
  options.rhodium.development = {
    enable = mkEnableOption "Enable development environment";
    enabledLanguages = mkOption {
      type = types.listOf types.str;
      default = [ "nix" "python" ];
      description = "Languages to enable by default";
    };
  };

  config = mkIf cfg.enable {
    # This enables the selected languages
    home.development.languages = builtins.listToAttrs (
      map
        (lang: {
          name = lang;
          value = { enable = true; };
        })
        cfg.enabledLanguages
    );
  };

  imports = [
    ./languages
  ];
}
