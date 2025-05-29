{ pkgs, ... }:

{
  imports = [
    ./obsidian.nix
    ./okular.nix
    ./texmaker.nix
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    # anytype
    # appflowy
    # logseq
    # roam-research
    # joplin
    # joplin-desktop
    # notion-app
  ];
}
