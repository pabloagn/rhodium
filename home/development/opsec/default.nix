{ config, lib, pkgs, ... }:
with lib;
{
  options = {
    programs.development.opsec = {
      enable = mkEnableOption "OpSec Suite" // {
        default = mkDefault false;
      };
    };
  };

  config = mkIf config.programs.development.opsec.enable {
    home.packages = with pkgs; [
      # Binary Analysis and Reverse Engineering
      # ------------------------------------------
      apktool
      ghidra
      radare2

      # Brute Forcing and Password Cracking
      # ------------------------------------------
      aircrack-ng
      hashcat
      hydra
      hydra-cli
      john
      johnny
      thc-hydra

      # Browser
      # ------------------------------------------
      tor

      # Exploitation Frameworks
      # ------------------------------------------
      metasploit

      # Forensics and Incident Response
      # ------------------------------------------
      autopsy

      # Information Gathering
      # ------------------------------------------
      maltego
      nmap
      # set
      social-engineer-toolkit
      wpscan

      # Network Analysis and Sniffing
      # ------------------------------------------
      wireshark
      wireshark-qt

      # Penetration Testing Tools
      # ------------------------------------------
      burpsuite
      lynis
      nikto
      sqlmap

      # Resources
      # ------------------------------------------
      wordlists
    ];
  };
}
