{ pkgs, ... }:

{
  environment.shells = with pkgs; [ zsh bash fish ];

  programs.zsh = {
    enable = true;
  };

  programs.bash = {
    completion.enable = true; # Required for home setting
  };

  programs.fish = {
    enable = true;
  };
  documentation.man.generateCaches = false;

}
