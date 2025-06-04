{ pkgs, pkgs-unstable, yaziPlugins, ... }:
let
  # Unpack only required plugins
  selectedPlugins = with yaziPlugins.plugins; [
    git
    full-border
    smart-enter
    ouch
    augment-command
    copy-file-contents
    wl-clipboard
  ];
in
{
  imports = [
    ./yazi/modules
  ];

  programs.yazi = {
    enable = true;
    # package = pkgs.yazi;
    package = pkgs-unstable.yazi; # Using unstable for now due to some plugin requirements
    plugins = builtins.listToAttrs (map
      (plugin: {
        name = plugin.name;
        value = plugin.src;
      })
      selectedPlugins);
  };
}
