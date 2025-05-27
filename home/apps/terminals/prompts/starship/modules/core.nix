{ config, ... }:
let
  iconTokens = config.theme.icons.iconsNerdFont;
  colorTokens = config.theme.colors;
in
{
  programs.starship.settings = {
    username = {
      format = "[$user]($style)";
      show_always = true;
      style = colorTokens.base0D or "blue";
    };

    hostname = {
      format = "[@$hostname]($style) ";
      ssh_only = false;
      style = colorTokens.base03 or "darkgray";
    };

    shlvl = {
      format = "[$shlvl]($style) ";
      style = "bold ${colorTokens.base0C or "cyan"}";
      threshold = 2;
      repeat = true;
      disabled = false;
    };

    cmd_duration = {
      format = "took [$duration]($style) ";
      style = colorTokens.base09 or "yellow";
    };

    directory = {
      format = "[$path]($style)( [$read_only]($read_only_style)) ";
      style = colorTokens.base0D or "blue";
    };

    nix_shell = {
      format = "[($name \\(develop\\) <- )$symbol]($style) ";
      impure_msg = "";
      symbol = iconTokens.programming.nixos.char or " ";
      style = "bold ${colorTokens.base08 or "red"}";
    };

    custom = { };

    character = {
      # TODO: Add unicode chars from lib instead
      error_symbol = "[~~>](bold ${colorTokens.base08 or "red"})";
      success_symbol = "[->>](bold ${colorTokens.base03 or "gray"})";
      vimcmd_symbol = "[<<-](bold ${colorTokens.base0A or "yellow"})";
      vimcmd_visual_symbol = "[<<-](bold ${colorTokens.base0C or "cyan"})";
      vimcmd_replace_symbol = "[<<-](bold ${colorTokens.base0E or "purple"})";
      vimcmd_replace_one_symbol = "[<<-](bold ${colorTokens.base0E or "purple"})";
    };

    time = {
      format = "\\[[$time]($style)\\]";
      disabled = false;
      style = colorTokens.base04 or "gray";
    };
  };
}
