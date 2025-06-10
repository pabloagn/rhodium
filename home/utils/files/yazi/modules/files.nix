{ pkgs }:

{
  # Themes
  "yazi/tokyonight-night.tmTheme".source = ../../bat/tokyonight-night.tmTheme;
  
  # Custom plugins
  "yazi/plugins/markdown.sh" = import ../plugins/markdown-preview.nix { inherit pkgs; };
}
