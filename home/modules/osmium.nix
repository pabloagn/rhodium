{
  config,
  lib,
  pkgs,
  userExtras,
  ...
}:
let
  # Flatten the nested group → entry structure into a flat attrset
  flatEntries = lib.concatMapAttrs (_group: entries: entries) userExtras.osmiumData;
in
{
  home.file."${config.xdg.dataHome}/rhodium-utils/osmium-bookmarks.json".source =
    pkgs.writeText "osmium-bookmarks.json" (builtins.toJSON flatEntries);
}
