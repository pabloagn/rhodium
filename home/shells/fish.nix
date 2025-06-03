{ config, pkgs, ... }:

let
  # common = import ./common { inherit config pkgs; };
  fishModules = import ./fish { inherit config pkgs; };
in
{
  programs.man.generateCaches = false;
  programs.fish = {
    enable = true;
    # shellAliases = common.aliases;

    shellInit = ''
      # Set vi key bindings
      fish_vi_key_bindings

      ${fishModules.environment}
      ${fishModules.fzfConfig}
      ${fishModules.defaults}
    '';

    interactiveShellInit = ''
      ${fishModules.atuin}
      ${fishModules.keybinds}
      ${fishModules.abbreviations}
      ${fishModules.theme}
      ${fishModules.prompt}
    '';

    functions = fishModules.functions;
  };
}
