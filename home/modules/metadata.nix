{
  config,
  pkgs,
  rhodiumLib,
  userPreferences,
  ...
}:
{
  home.file."${config.xdg.dataHome}/rhodium-utils/metadata.json".source =
    pkgs.writeText "rhodium-utils-metadata.json" (
      builtins.toJSON (rhodiumLib.generators.utilsMetadataGenerators userPreferences.metadata)
    );
}
