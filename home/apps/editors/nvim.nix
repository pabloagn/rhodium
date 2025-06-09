{ ... }:

{
  imports = [
    ./nvim/clean.nix
    ./nvim
  ];

  programs.neovim = {
    enable = true;
  };
}
