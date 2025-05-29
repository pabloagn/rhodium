{ config, rhodiumLib, ... }:
let
  icons = config.theme.icons.iconsNerdFont;
  colors = config.theme.colors;
  getIcon = rhodiumLib.formatters.iconFormatter.getIcon;
in
{
  programs.starship.settings = {
    username = {
      format = "[$user]($style)";
      show_always = true;
      style = colors.base0D;
    };

    hostname = {
      format = "[@$hostname]($style) ";
      ssh_only = false;
      style = colors.base03;
    };

    shlvl = {
      format = "[$shlvl]($style) ";
      style = "bold ${colors.base0C}";
      threshold = 2;
      repeat = true;
      disabled = false;
    };

    cmd_duration = {
      format = "took [$duration]($style) ";
      style = colors.base09;
    };

    directory = {
      format = "[$path]($style)( [$read_only]($read_only_style)) ";
      style = colors.base0D;
    };

    nix_shell = {
      format = "[($name \\(develop\\) <- )$symbol]($style) ";
      impure_msg = "";
      symbol = getIcon icons.programming.nixos "❄️";
      style = "bold ${colors.base08}";
    };

    character = {
      error_symbol = "[~~>](bold ${colors.base08})";
      success_symbol = "[->>](bold ${colors.base03})";
      vimcmd_symbol = "[<<-](bold ${colors.base0A})";
      vimcmd_visual_symbol = "[<<-](bold ${colors.base0C})";
      vimcmd_replace_symbol = "[<<-](bold ${colors.base0E})";
      vimcmd_replace_one_symbol = "[<<-](bold ${colors.base0E})";
    };

    time = {
      format = "\\[[$time]($style)\\]";
      disabled = false;
      style = colors.base04;
    };
  };
}
