{ config, lib, pkgs, ... }:

{
  # Developer-specific role configuration
  programs.bash.shellAliases = {
    g = "git";
    d = "docker";
    dc = "docker-compose";
  };

  home.sessionVariables = {
    EDITOR = "code";
    VISUAL = "code";
  };
}
