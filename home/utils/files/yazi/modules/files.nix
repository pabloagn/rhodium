{pkgs}: {
  "yazi/plugins/markdown.sh" = import ../plugins/markdown-preview.nix {inherit pkgs;};
}
