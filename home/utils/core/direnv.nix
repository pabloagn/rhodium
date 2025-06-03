{ ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true; # Cache .env environment
  };
}
