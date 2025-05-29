{ config, pkgs, pkgs-unstable, ... }:
let
  markdownPreviewScript = pkgs.writeShellScript "yazi-markdown-preview" ''
    #!${pkgs.runtimeShell}

    # Dependencies are made available in PATH by the Nix wrapper
    # Check commands just in case
    if ! command -v pandoc >/dev/null 2>&1; then
      echo "Preview Error: 'pandoc' command not found in wrapper environment." >&2
      exit 1
    fi
    if ! command -v w3m >/dev/null 2>&1; then
      echo "Preview Error: 'w3m' command not found in wrapper environment." >&2
      exit 1
    fi

    FILE_PATH="$1"
    # Yazi sets $YACOL (pane width), default to 80 if unset
    WIDTH="''${YACOL:-80}" # Use ''${} to escape Nix interpolation

    # Use full paths for extra robustness within the script, though PATH should work
    (${pkgs.pandoc}/bin/pandoc -f markdown -t html --standalone "$FILE_PATH" 2>&1 | ${pkgs.w3m}/bin/w3m -T text/html -dump -cols "$WIDTH")

    # Exit with the status code of the last command (w3m)
    exit $?
  '';
in
{
  programs.yazi = {
    enable = true;
    # TODO:
    #   - Check if the issues were fixed.
    #   - If true, we can remove the unstable

    # package = pkgs-unstable.yazi;
    package = pkgs.yazi;
  };

  xdg.configFile."yazi/yazi.toml" = {
    source = ./yazi/yazi.toml; # Ensure this source file HAS the markdown rule added!
    # Remember to include { mime = "text/markdown", run = "markdown" }
    # in the [plugin].previewers section of ./yazi.toml, before the text/* rule.
  };

  # Manage theme file
  xdg.configFile."yazi/theme.toml" = {
    source = ./yazi/theme.toml;
  };

  # Manage syntax highlighting theme if needed by previewers (like bat used internally)
  xdg.configFile."yazi/catppuccin-mocha.tmTheme" = {
    source = ./bat/catppuccin-mocha.tmTheme;
  };

  xdg.configFile."yazi/plugins" = {
    source = (pkgs.runCommand "yazi-plugins-dir-empty" {} ''mkdir -p $out'');
    recursive = true;
  };

  xdg.configFile."yazi/plugins/markdown.sh" = {
    source = markdownPreviewScript;
    executable = true;
  };
}
