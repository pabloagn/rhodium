{ pkgs, ... }:
{
  imports = [
    ./firefox.nix
    ./librewolf.nix
    ./qutebrowser.nix
    ./zen.nix
  ];

  home.packages = with pkgs; [
    brave
    tor

    # --- Terminal Browsers ---
    w3m # Text-mode WWW browser
    lynx # Classic text browser
    browsh # Modern text-based browser using Firefox
  ];
}
