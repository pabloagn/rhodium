{ ... }:

{
  imports = [
    ./kitty
  ];

  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableZshIntegration = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      enableGitIntegration = true;
    };
  };
}
