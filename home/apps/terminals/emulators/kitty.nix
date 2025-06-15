{...}: {
  imports = [
    ./kitty
  ];

  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    shellIntegration = {
      enableZshIntegration = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
  };
}
