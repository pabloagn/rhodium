{ pkgs, yaziPlugins, ... }:
let
  # Unpack only required plugins
  selectedPlugins = with yaziPlugins.plugins; [
    git
    glow
    full-border
    smart-enter
  ];
in
{
  imports = [
    ./yazi/modules
  ];

  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    plugins = builtins.listToAttrs (map
      (plugin: {
        name = plugin.name;
        value = plugin.src;
      })
      selectedPlugins);
  };
}
