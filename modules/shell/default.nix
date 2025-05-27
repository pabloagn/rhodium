{ config, pkgs, ... }:

{
  environment.shells = with pkgs; [ zsh bash ];

  programs.zsh = {
    enable = true;
  };
}
