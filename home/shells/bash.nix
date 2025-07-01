{
  config,
  pkgs,
  ...
}: let
  aliases = import ./common/aliases.nix;
in {
  programs.bash = {
    enableCompletion = true;
    shellAliases = aliases;
    historyFile = "${config.home.XDG_CACHE_HOME}/bash/.bash_history";
    historySize = 10000000;
    # TODO: Niri-related. Eventually move from here.
    profileExtra = ''
      if [ -z "$DISPLAY" ] && [ "$TTY" = "/dev/tty1" ]; then
        exec ${pkgs.niri}/bin/niri-session
      fi
    '';
  };
}
