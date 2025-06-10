{ pkgs }:

{
  # Themes
  # "yazi/theme.toml".source = ../theme.toml;
  "yazi/catppuccin-mocha.tmTheme".source = ../../bat/catppuccin-mocha.tmTheme;
  "yazi/tokyonight-night.tmTheme".source = ../../bat/tokyonight-night.tmTheme;

  # Custom plugins
  "yazi/plugins/markdown.sh" = import ../plugins/markdown-preview.nix { inherit pkgs; };
}
