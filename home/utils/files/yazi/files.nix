{ pkgs }:

{
  # Config
  "yazi/yazi.toml".source = ./yazi/yazi.toml;
  "yazi/theme.toml".source = ./yazi/theme.toml;
  "yazi/keymap.toml".source = ./yazi/keymap.toml;
  "yazi/catppuccin-mocha.tmTheme".source = ./bat/catppuccin-mocha.tmTheme;

  # Custom plugins
  "yazi/plugins/markdown.sh" = import ./plugins/markdown-preview.nix { inherit pkgs; };
}
