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

  documentation.man.generateCaches = false; # Required since fish creates a massive database (eternal build)

  # Required for fish
  programs.command-not-found.enable = false;

  # Optional: Use nix-index instead (better for flakes)
  # programs.nix-index = {
  # enable = true;
  # enableFishIntegration = true;
  # };
}
