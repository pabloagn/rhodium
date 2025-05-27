{ pkgs, ... }:

{
  imports = [
    ./modules
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-remote;
    # package = pkgs.neovim-unwrapped;
  };
}
