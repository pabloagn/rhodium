{ config, ... }:
{
  exec-once = "bash ${config.home.sessionVariables.XDG_BIN_HOME}/desktop-autostart.sh";
}
