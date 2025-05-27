{ config, rhodiumLib, ... }:
let
  iconTokensUnicode = config.theme.icons.iconsUnicode;
  getIcon = rhodiumLib.formatters.iconFormatter.getIcon;
in
{
  programs.starship.settings = {
    git_status = {
      format = "([\\[$all_status$ahead_behind\\]]($style) )";
      # style = "bold blue";
      conflicted = "=";
      ahead = getIcon iconTokensUnicode.arrows.up;
      behind = getIcon iconTokensUnicode.arrows.down;
      diverged = getIcon iconTokensUnicode.arrows.upDown;
      untracked = getIcon iconTokensUnicode.status.question;
      stashed = getIcon iconTokensUnicode.status.stash;
      modified = getIcon iconTokensUnicode.status.exclamation;
      staged = getIcon iconTokensUnicode.math.plus;
      renamed = getIcon iconTokensUnicode.typography.quoteRight;
      deleted = getIcon iconTokensUnicode.status.cross;
    };
  };
}
