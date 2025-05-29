{ config, ... }:
# let
#   iconTokens = config.theme.icons.iconsNerdFont;
# in
{
  programs.starship.settings = {
    gcloud.format = "on [$symbol$active(/$project)(\\($region\\))]($style)";
    aws.format = "on [$symbol$profile(\\($region\\))]($style)";
  };
}
