{ pkgs }:

{
  # Config
  "yazi/theme.toml".source = ../theme.toml;
  "yazi/catppuccin-mocha.tmTheme".source = ../../bat/catppuccin-mocha.tmTheme;

  # Custom plugins
  "yazi/plugins/markdown.sh" = import ../plugins/markdown-preview.nix { inherit pkgs; };
}
