{ pkgs, ... }:
{
  imports = [
    ./discord.nix
    # ./mastodon.nix
    ./matrix.nix
    ./signal.nix
    ./telegram.nix
  ];
}
