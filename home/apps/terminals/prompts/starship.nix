{ ... }:

{
  imports = [
    ./starship
  ];

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
}
