# home/apps/opsec/default.nix

{ config, lib, pkgs, rhodium, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.opsec;
  categoryName = "opsec";

  packageSpecs = [
    # Binary Analysis and Reverse Engineering
    { name = "apktool"; pkg = pkgs.apktool; description = "Tool for reverse engineering Android apk files"; }
    { name = "ghidra"; pkg = pkgs.ghidra; description = "Software reverse engineering (SRE) framework"; }
    { name = "radare2"; pkg = pkgs.radare2; description = "Reverse engineering framework and command-line toolset"; }

    # Brute Forcing and Password Cracking
    { name = "aircrack-ng"; pkg = pkgs.aircrack-ng; description = "Set of tools for auditing wireless networks"; }
    { name = "hashcat"; pkg = pkgs.hashcat; description = "Advanced password recovery utility"; }
    { name = "hydra"; pkg = pkgs.hydra; description = "Parallelized login cracker (thc-hydra)"; }
    { name = "john"; pkg = pkgs.john; description = "John the Ripper password cracker"; }
    { name = "johnny"; pkg = pkgs.johnny; description = "GUI for John the Ripper"; }

    # Exploitation Frameworks
    { name = "metasploit"; pkg = pkgs.metasploit; description = "Advanced open-source platform for developing, testing, and using exploit code"; }

    # Forensics and Incident Response
    { name = "autopsy"; pkg = pkgs.autopsy; description = "Digital forensics platform and graphical interface to The Sleuth Kit"; }

    # Information Gathering
    { name = "maltego"; pkg = pkgs.maltego; description = "Interactive data mining tool for online investigations"; }
    { name = "nmap"; pkg = pkgs.nmap; description = "Utility for network discovery and security auditing"; }
    { name = "set"; pkg = pkgs.set; description = "Social-Engineer Toolkit (SET)"; }
    { name = "wpscan"; pkg = pkgs.wpscan; description = "WordPress security scanner"; }

    # Network Analysis and Sniffing
    { name = "wireshark"; pkg = pkgs.wireshark-qt; description = "Network protocol analyzer (with Qt GUI)"; }

    # Penetration Testing Tools
    { name = "burpsuite"; pkg = pkgs.burpsuite; description = "Graphical tool for testing Web application security"; }
    { name = "lynis"; pkg = pkgs.lynis; description = "Security auditing tool for Unix-based systems"; }
    { name = "nikto"; pkg = pkgs.nikto; description = "Web server scanner"; }
    { name = "sqlmap"; pkg = pkgs.sqlmap; description = "Automatic SQL injection and database takeover tool"; }

    # Resources
    { name = "wordlists"; pkg = pkgs.wordlists; description = "Collection of wordlists for password cracking and other security tasks"; }
  ];

in
{
  options.rhodium.home.apps.opsec = {
    enable = mkEnableOption "Rhodium's Security Operations (OpSec) tools";
  } // rhodium.lib.mkIndividualPackageOptions packageSpecs;

  config = mkIf cfg.enable {
    home.packages = concatMap (spec: if cfg.${spec.name}.enable then [ spec.pkg ] else [ ]) packageSpecs;
  };
}
