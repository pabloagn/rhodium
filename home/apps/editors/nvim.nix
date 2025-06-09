{ ... }:

{
  imports = [
    # TODO: Declare as option
    # ./nvim/clean.nix
    ./nvim
  ];

  programs.neovim = {
    enable = true;
  };
}

