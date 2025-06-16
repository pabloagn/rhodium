{pkgs, ...}: {
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
    command-not-found.enable = false; # Required for fish
  };

  # TODO: Fix this
  documentation.man.generateCaches = false; # Required since fish creates a massive database (eternal build)

  # TODO: Set up nix-index
  # programs.nix-index = {
  # enable = true;
  # enableFishIntegration = true;
  # };
}
