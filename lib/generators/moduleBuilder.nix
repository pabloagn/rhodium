{ config, lib, ... }:

let
  mkLangModule =
    {
      optionPath,
      description,
      packages,
    }:
    {
      options =
        lib.mkOption {
          type = lib.types.attrsOf lib.types.anything;
          default = { };
        }
        // lib.attrsets.setAttrByPath optionPath {
          enable = lib.mkEnableOption description;
        };

      config = lib.mkIf (lib.attrsets.getAttrFromPath optionPath config) {
        home.packages = packages;
      };
    };
in
{
  inherit mkLangModule;
}
