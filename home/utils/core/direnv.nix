{ ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true; # Cache .env environment
    silent = true; # Silence direnv messages
  };
}
