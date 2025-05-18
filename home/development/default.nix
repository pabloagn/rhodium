# home/development/default.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.development;

  # Convert simple list entries to attribute sets
  processLanguages = langs:
    map
      (lang:
        if builtins.isString lang then
          { name = lang; value = { enable = true; }; }
        else if builtins.isAttrs lang && builtins.hasAttr "name" lang then
          { name = lang.name; value = removeAttrs lang [ "name" ]; }
        else
          throw "Invalid language specification"
      )
      langs;
in
{
  imports = [
    ./databases
    ./editors
    ./languages
    ./tools
    ./virtualization
  ];

  options.rhodium.development = {
    enable = mkEnableOption "Enable development environment";
    enabledLanguages = mkOption {
      type = types.listOf (types.either types.str types.attrs);
      default = [ "nix" "rust" "go" "python" "c" "cpp" ];
      description = "Languages to enable by default";
    };
  };

  config = mkIf cfg.enable {
    home.development.databases = enable;
    home.development.editors = enable;
    home.development.languages = builtins.listToAttrs (processLanguages cfg.enabledLanguages);
    home.development.tools = enable;
    home.development.virtualization = enable;
  };
}
