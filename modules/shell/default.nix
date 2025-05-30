{ config, pkgs, ... }:

{
  environment.shells = with pkgs; [ zsh bash ];

  programs.zsh = {
    enable = true;
  };
  programs.bash = {
    completion.enable = true; # Required for home setting
  };
}
