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

  # Disable manuals as nmd fails to build often
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };
}
