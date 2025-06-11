{ pkgs, ... }:

{
  environment.shells = with pkgs; [
    zsh
    bash
    fish
    nushell
  ];

  programs = {
    zsh.enable = true;
    bash.completion.enable = true; # Required for home setting
    fish.enable = true;
    nushell.enable = true;
  };

  # TODO: Fix this
  documentation.man.generateCaches = false; # Required since fish creates a massive database (eternal build)

  # Required for fish
  programs.command-not-found.enable = false;

  # Optional: Use nix-index instead (better for flakes)
  # programs.nix-index = {
  # enable = true;
  # enableFishIntegration = true;
  # };
}
