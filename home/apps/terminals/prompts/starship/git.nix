{ config, rhodiumLib, ... }:

let
  unicodeIcons = config.theme.icons.iconsUnicode;
  getIcon = rhodiumLib.formatters.iconFormatter.getIcon;
in
{
  programs.starship.settings = {
    git_status = {
      format = "([\\[$all_status$ahead_behind\\]]($style) )";
      conflicted = "=";
      ahead = getIcon unicodeIcons.arrows.up "⇡";
      behind = getIcon unicodeIcons.arrows.down "⇣";
      diverged = getIcon unicodeIcons.arrows.upDown "⇕";
      untracked = getIcon unicodeIcons.status.question "?";
      stashed = getIcon unicodeIcons.currency.dollar "$";
      modified = getIcon unicodeIcons.status.exclamation "!";
      staged = getIcon unicodeIcons.math.plus "+";
      renamed = getIcon unicodeIcons.typography.quoteRight "»";
      deleted = getIcon unicodeIcons.status.cross "✗";
    };
  };
}
