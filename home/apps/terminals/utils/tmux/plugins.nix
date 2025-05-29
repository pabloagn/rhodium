{ pkgs, ... }:
# TODO:Populate this bit
{
  programs.tmux = {
    plugins = with pkgs; [
      tmuxPlugins.tmux-fzf
     ];
  };
}
