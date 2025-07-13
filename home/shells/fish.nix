{ fishPlugins, ... }:
{
  # TODO: Fix this
  programs.man.generateCaches = false;

  imports = [
    ./fish
  ];

  programs.fish = {
    enable = true;
    plugins = fishPlugins;
  };
}
