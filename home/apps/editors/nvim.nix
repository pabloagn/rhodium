{ pkgs, ... }:

{
  imports = [
    ./nvim
  ];

  programs.neovim = {
    enable = true;
    # package = pkgs.neovim;

programs.neovide = {
    enable = true;
    settings = {
      # Transparency settings
      transparency = 0.8;
      
      # Other optional settings
      fork = false;
      frame = "full";
      idle = true;
      maximized = false;
      tabs = true;
      theme = "auto";
      vsync = true;
      
      font = {
        size = 12.0;
      };
    };
  };
}
