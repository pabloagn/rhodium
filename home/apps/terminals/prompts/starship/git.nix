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
      ahead = getIcon unicodeIcons.arrows.basic.up "⇡";
      behind = getIcon unicodeIcons.arrows.basic.down "⇣";
      diverged = getIcon unicodeIcons.arrows.basic.upDown "⇕";
      untracked = getIcon unicodeIcons.technical.status.punctuation.question "?";
      stashed = getIcon unicodeIcons.currency.dollar "$";
      modified = getIcon unicodeIcons.technical.status.punctuation.exclamation "!";
      staged = getIcon unicodeIcons.mathematical.operators.plus "+";
      renamed = getIcon unicodeIcons.typography.quotes.rightAngleQuote "»";
      deleted = getIcon unicodeIcons.technical.status.marks.cross "✗";
    };
  };
}
