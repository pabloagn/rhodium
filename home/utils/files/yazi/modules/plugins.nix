{ lib, yaziPlugins, ... }:

lib.mapAttrs (pluginName: pluginDef: pluginDef.src) yaziPlugins.plugins

