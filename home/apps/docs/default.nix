{pkgs, ...}: {
  imports = [
    ./obsidian.nix
    ./okular.nix
    ./standardnotes.nix
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    # anytype
    # appflowy
    # joplin
    # joplin-desktop
    # logseq
    # notion-app
    # roam-research
  ];
}
