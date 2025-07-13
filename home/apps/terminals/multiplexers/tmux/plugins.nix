{ pkgs, ... }:
{
  programs.tmux = {
    plugins = with pkgs; [
      tmuxPlugins.tmux-fzf
    ];
  };
}
