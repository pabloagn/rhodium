{ pkgs, ... }:

{
  imports = [
    ./nvim
  ];

  programs.neovim = {
    enable = true;
    # package = pkgs.neovim;
  };
}
