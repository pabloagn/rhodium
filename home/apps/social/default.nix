{ pkgs, ... }:
{
  imports = [
    ./discord.nix
    ./mastodon.nix
    ./matrix.nix
    ./signal.nix
    ./telegram.nix
  ];

  home.packages = with pkgs; [
    weechat # Extensible IRC/chat client
  ];
}
