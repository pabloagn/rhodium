{ pkgs, ... }:

{
  imports = [
    ./ghostty
  ];

  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };
}
