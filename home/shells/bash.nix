{config, ...}: let
  aliases = import ./common/aliases.nix;
  # functions = import ../functions.nix;
in {
  programs.bash = {
    enableCompletion = true;
    shellAliases = aliases;
    historyFile = "${config.home.XDG_CACHE_HOME}/bash/.bash_history";
    historySize = 10000000;
  };
}
