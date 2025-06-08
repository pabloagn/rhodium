{ config, fishPlugins, ... }:

let
  common = import ./common { };
  fishFunctions = common.functions.fishFunctions;
  fishAliases = common.aliases.commonAliases;
  fishModules = import ./fish { inherit config; };
in
{
  programs.man.generateCaches = false;

  programs.fish = {
    enable = true;

    plugins = fishPlugins;

    shellAliases = fishAliases;

    functions = fishFunctions;

    shellInit = ''
      # Set vi key bindings
      fish_vi_key_bindings

      ${fishModules.defaults}
    '';

    interactiveShellInit = ''
      ${fishModules.atuin}
      ${fishModules.keybinds}
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
