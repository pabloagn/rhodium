{pkgs, ...}: {
  home.packages = with pkgs; [
    roam-research
  ];
}
