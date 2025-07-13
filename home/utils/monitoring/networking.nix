{ pkgs, ... }:
{
  imports = [
  ];

  home.packages = with pkgs; [
    gping # Better ping (includes graph)
    dogdns # Command line dns client
  ];
}
