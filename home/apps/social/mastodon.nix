{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # mastodon # Mastodon server (probably not needed locally)
    tut # Mastodon TUI client
  ];
}

