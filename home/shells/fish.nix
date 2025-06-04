{ config, fishPlugins, ... }:

let
  common = import ./common { };
  fishFunctions = common.fishFunctions;
  fishAliases = common.commonAliases;
  fishModules = import ./fish { inherit config; };
in
{
  programs.man.generateCaches = false;
  programs.fish = {
    enable = true;

    # Ingest all plugins from flake
    plugins = fishPlugins.pluginsList;

    # Ingest aliases
    shellAliases = fishAliases;

    # Ingest functions
    functions = fishFunctions;
    # {
    #   yy = fishFunctions.yy;
    #   fzp = fishFunctions.fzp;
    #   xrt = fishFunctions.xrt;
    #   mkz = fishFunctions.mkz;
    #   bkp = fishFunctions.bkp;
    # };

    shellInit = ''
      # Set vi key bindings
      fish_vi_key_bindings

      ${fishModules.fzfConfig}
      ${fishModules.defaults}
    '';

    interactiveShellInit = ''
      ${fishModules.atuin}
      ${fishModules.keybinds}
      ${fishModules.abbreviations}
      ${fishModules.theme}
      ${fishModules.prompt}

      # Plugin setup
      # colored-man
      # TODO: Style this
      set -g man_blink -o red
      set -g man_bold -o green
      set -g man_standout -b black 93a1a1
      set -g man_underline -u 93a1a1

      # TODO: Add other plugin configs
    '';

  };
}
