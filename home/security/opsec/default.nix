# home/security/opsec/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.security.opsec;
in
{
  options.rhodium.security.opsec = {
    enable = mkEnableOption "Security operations and penetration testing tools";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Binary Analysis and Reverse Engineering
      apktool
      ghidra
      radare2

      # Brute Forcing and Password Cracking
      aircrack-ng
      hashcat
      hydra-cli
      john
      johnny
      thc-hydra

      # Exploitation Frameworks
      metasploit

      # Forensics and Incident Response
      autopsy

      # Information Gathering
      maltego
      nmap
      social-engineer-toolkit
      wpscan

      # Network Analysis and Sniffing
      wireshark

      # Penetration Testing Tools
      burpsuite
      lynis
      nikto
      sqlmap

      # Resources
      wordlists
    ];
  };
}
