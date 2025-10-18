{ pkgs, ... }:
{
  imports = [
  ];

  home.packages = with pkgs; [
    dogdns # Command line dns client
    gping # Better ping (includes graph)
    netscanner # TUI network scanner
  ];
}
