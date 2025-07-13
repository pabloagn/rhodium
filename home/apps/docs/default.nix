{ pkgs, ... }:
{
  imports = [
    # ./anytype.nix
    # ./appflowy.nix
    # ./joplin.nix
    # ./logseq.nix
    # ./notion.nix
    ./obsidian.nix
    ./okular.nix
    # ./roam.nix
    ./standardnotes.nix
    ./zathura.nix
  ];
}
