{ pkgs, ... }:

{
  home.packages = with pkgs; [
    obsidian
    zathura
    kdePackages.okular
    texmaker
    # anytype
    # appflowy
    # logseq
    # roam-research
    # joplin
    # joplin-desktop
    # notion-app
  ];
}
