# home/apps/browsers/zen.nix

{ lib, config, pkgs, inputs, _haumea, rhodiumLib, ... }:

with lib;
let
  categoryName = _haumea.name;
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  hasZenBrowser = inputs ? zen-browser;
  system = pkgs.stdenv.hostPlatform.system;
in
{
  options = setAttrByPath _haumea.configPath (
    rhodiumLib.mkAppModuleOptions
      {
        appName = categoryName;
        hasDesktop = true;
        defaultEnable = false;
      }
    //
    {
      variant = mkOption {
        type = types.enum [ "specific" "generic" ];
        default = "specific";
        description = ''
          Which variant of Zen Browser to install.
          - "specific": Optimized for newer CPUs and kernels (same as 'default')
          - "generic": Maximizes compatibility with old CPUs and kernels
        '';
        example = "generic";
      };
    }
  );

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages =
      let
        hasPkgsForSystem = hasZenBrowser && inputs.zen-browser.packages ? ${system};
        zenPackage =
          if !hasPkgsForSystem then null
          else if cfg.variant == "specific" then inputs.zen-browser.packages.${system}.specific
          else if cfg.variant == "generic" then inputs.zen-browser.packages.${system}.generic
          else inputs.zen-browser.packages.${system}.default;
      in
      lib.optional (zenPackage != null && hasZenBrowser) zenPackage;

    warnings = lib.optional (hasZenBrowser && !(inputs.zen-browser.packages ? ${system}))
      "Zen browser packages not available for system ${system}";
  };
}
