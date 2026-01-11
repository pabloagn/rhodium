{ pkgs, ... }:
{
  imports = [
  ];

  home.packages = with pkgs; [
    dogdns # Command line dns client
    gping # Better ping (includes graph)
    netscanner # TUI network scanner
    termshark # Terminal UI for tshark/Wireshark
    trippy # Network diagnostic tool like mtr with TUI
  ];
}
