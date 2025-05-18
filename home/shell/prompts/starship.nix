# home/shell/prompts/starship.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.shell.prompts.starship;
in
{
  options.rhodium.shell.prompts.starship = {
    enable = mkEnableOption "Rhodium's Starship prompt configuration";
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;

      settings =
        let
          hostInfo = "$username$hostname($shlvl)($cmd_duration)";
          nixInfo = "($nix_shell)";
          localInfo = "$directory($git_branch$git_commit$git_state$git_status)($aws$gcloud$openstack)";
          prompt = "$jobs$character";
        in
        {
          format = ''
            ${hostInfo} $fill ${nixInfo}
            ${localInfo} $fill $time
            ${prompt}
          '';

          fill.symbol = " ";

          # Core
          username = {
            format = "[$user]($style)";
            show_always = true;
          };
          hostname = {
            format = "[@$hostname]($style) ";
            ssh_only = false;
            style = "darkgray";
          };
          shlvl = {
            format = "[$shlvl]($style) ";
            style = "bold cyan";
            threshold = 2;
            repeat = true;
            disabled = false;
          };
          cmd_duration = {
            format = "took [$duration]($style) ";
          };

          directory = {
            format = "[$path]($style)( [$read_only]($read_only_style)) ";
          };
          nix_shell = {
            format = "[($name \\(develop\\) <- )$symbol]($style) ";
            impure_msg = "";
            symbol = " ";
            style = "bold crimson";
          };
          custom = { };

          character = {
            error_symbol = "[~~>](bold crimson)";
            success_symbol = "[->>](bold darkgray)";
            vimcmd_symbol = "[<<-](bold yellow)";
            vimcmd_visual_symbol = "[<<-](bold cyan)";
            vimcmd_replace_symbol = "[<<-](bold purple)";
            vimcmd_replace_one_symbol = "[<<-](bold purple)";
          };

          time = {
            format = "\\[[$time]($style)\\]";
            disabled = false;
          };


          # Git status customization
          git_status = {
            format = "([\\[$all_status$ahead_behind\\]]($style) )";
            # style = "bold blue";
            conflicted = "=";
            ahead = "↑";
            behind = "↓";
            diverged = "↕";
            untracked = "?";
            stashed = "<>";
            modified = "!";
            staged = "+";
            renamed = "»";
            deleted = "x";
          };

          # Cloud formatting
          gcloud.format = "on [$symbol$active(/$project)(\\($region\\))]($style)";
          aws.format = "on [$symbol$profile(\\($region\\))]($style)";
          aws.symbol = " ";

          # Symbols
          conda.symbol = " ";
          dart.symbol = " ";
          directory.read_only = " ";
          docker_context.symbol = " ";
          elm.symbol = " ";
          elixir.symbol = "";
          gcloud.symbol = " ";
          git_branch.symbol = " ";
          golang.symbol = " ";
          haskell.symbol = " ";
          hg_branch.symbol = " ";
          java.symbol = " ";
          julia.symbol = " ";
          lua.symbol = " ";
          memory_usage.symbol = "󰍛 ";
          nim.symbol = "󰆥 ";
          nodejs.symbol = " ";
          package.symbol = "󰏗 ";
          perl.symbol = " ";
          php.symbol = " ";
          python.symbol = " ";
          ruby.symbol = " ";
          rust.symbol = " ";
          scala.symbol = " ";
          shlvl.symbol = "";
          swift.symbol = "󰛥 ";
          terraform.symbol = "󱁢";
          # vim.symbol = " ";
        };
    };
  };
}
