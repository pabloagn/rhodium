{ config, pkgs, ... }:

{
  environment.shells = with pkgs; [ zsh bash ];

  programs.zsh = {
    enable = true;
  };
  programs.bash = {
    enable = true;
    enableCompletion = true; # Required for home setting
  };
}
