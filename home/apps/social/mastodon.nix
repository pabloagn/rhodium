{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mastodon
  ];
}

