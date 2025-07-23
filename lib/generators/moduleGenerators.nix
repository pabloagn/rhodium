{ lib }:
{
  mkPkgModule =
    args:
    let
      path = args.path or (throw "mkPkgModule requires 'path'");
      description = args.description or (throw "mkPkgModule requires 'description'");
      getPkgs = args.getPkgs or (throw "mkPkgModule requires 'getPkgs'");
      config = args.config or (throw "mkPkgModule requires 'config'");
      pkgs = args.pkgs or (throw "mkPkgModule requires 'pkgs'");
      cfg = lib.attrByPath path config;
    in
    {
      options = lib.setAttrByPath path {
        enable = lib.mkEnableOption description;
      };

      config = lib.mkIf cfg.enable {
        home.packages = getPkgs pkgs;
      };
    };

  mkModule = throw "mkModule is not yet implemented in the new style.";
}
