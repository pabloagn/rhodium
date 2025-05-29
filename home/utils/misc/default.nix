{ pkgs }:
{
  home.packages = with pkgs; [
    via # GUI for adjusting RGB lighting
    cowsay
    disfetch
  ];
}
