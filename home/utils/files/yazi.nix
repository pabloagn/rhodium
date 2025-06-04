{ pkgs, yaziPlugins, ... }:

{
  imports = [
    ./yazi/modules
  ];

  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    plugins = yaziPlugins.pluginsList;
  };
}
