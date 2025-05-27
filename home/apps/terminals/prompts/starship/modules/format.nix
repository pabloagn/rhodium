{ config, rhodiumLib, ... }:
let
  iconTokens = config.theme.icons.iconsNerdFont;
  formatIcon = rhodiumLib.formatters.iconFormatter.formatIcon;
in
{
  programs.starship.settings = let
    hostInfo = "$username$hostname($shlvl)($cmd_duration)";
    nixInfo = "($nix_shell)";
    localInfo = "$directory($git_branch$git_commit$git_state$git_status)($aws$gcloud$openstack)";
    prompt = "$jobs$character";
  in {
    format = ''
      ${hostInfo} $fill ${nixInfo}
      ${localInfo} $fill $time
      ${prompt}
    '';

    fill.symbol = " ";
  };
}
