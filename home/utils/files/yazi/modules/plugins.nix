{ yaziPlugins, ... }:

let
  # Unpack only required plugins
  selectedPlugins = with yaziPlugins.plugins; [
    git
    full-border
    yatline
    miller
    # smart-enter
    # ouch
    # augment-command
    # copy-file-contents
    # wl-clipboard
    # hexyl # TODO: Not ready with yazi latest yet
    # mime-ext
    # file-actions
    # mount
    # smart-filter
  ];
in
builtins.listToAttrs (map
  (plugin: {
    name = plugin.name;
    value = plugin.src;
  })
  selectedPlugins)
  
