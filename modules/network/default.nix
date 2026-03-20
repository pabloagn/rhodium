{ ... }:
{
  imports = [
    ./atuin-server.nix
    ./avahi.nix
    ./plex.nix
    ./roon.nix
    ./tailscale-client.nix
  ];
}
