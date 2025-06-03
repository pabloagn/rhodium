{ config, pkgs, pkgs-unstable, ... }:
let
  markdownPreviewScript = pkgs.writeShellScript "yazi-markdown-preview" ''
    #!${pkgs.runtimeShell}
    if ! command -v pandoc >/dev/null 2>&1; then
      echo "Preview Error: 'pandoc' command not found in wrapper environment." >&2
      exit 1
    fi
    if ! command -v w3m >/dev/null 2>&1; then
      echo "Preview Error: 'w3m' command not found in wrapper environment." >&2
      exit 1
    fi
    FILE_PATH="$1"
    WIDTH="''${YACOL:-80}"
    (${pkgs.pandoc}/bin/pandoc -f markdown -t html --standalone "$FILE_PATH" 2>&1 | ${pkgs.w3m}/bin/w3m -T text/html -dump -cols "$WIDTH")
    exit $?
  '';
in
{
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;

    # Use plugins from nixpkgs
    plugins = {
      full-border = pkgs.yaziPlugins.full-border;
      miller = pkgs.yaziPlugins.miller;
      ouch = pkgs.yaziPlugins.ouch;
      glow = pkgs.yaziPlugins.glow;
      git = pkgs.yaziPlugins.git;
      smart-enter = pkgs.yaziPlugins.smart-enter;
      diff = pkgs.yaziPlugins.diff;
      chmod = pkgs.yaziPlugins.chmod;
    };

    initLua = ''
      -- Complete borders
      require("full-border"):setup {
        type = ui.Border.ROUNDED,  -- Options: ui.Border.PLAIN, ui.Border.ROUNDED
      }

      -- Git status in file list
      require("git"):setup()

      # TODO: Complete this
    '';
  };

  # Your existing config files
  xdg.configFile."yazi/yazi.toml" = {
    source = ./yazi/yazi.toml;
  };

  xdg.configFile."yazi/theme.toml" = {
    source = ./yazi/theme.toml;
  };

  xdg.configFile."yazi/catppuccin-mocha.tmTheme" = {
    source = ./bat/catppuccin-mocha.tmTheme;
  };

  # Your markdown preview plugin
  xdg.configFile."yazi/plugins/markdown.sh" = {
    source = markdownPreviewScript;
    executable = true;
  };
}
