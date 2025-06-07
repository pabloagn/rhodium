{ yaziPlugins, ... }:

let
  # Unpack only required plugins
  selectedPlugins = with yaziPlugins.plugins; [
    git
    full-border
    yatline
    miller
  ];
in
builtins.listToAttrs (map
  (plugin: {
    name = plugin.name;
    value = plugin.src;
  })
  selectedPlugins)
  
