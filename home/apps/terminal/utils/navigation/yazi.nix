# home/apps/terminal/utils/yazi.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.terminal.utils.yazi;

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
  options.rhodium.home.apps.terminal.utils.yazi = {
    enable = mkEnableOption "Rhodium's Yazi configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Main
      pkgs-unstable.yazi
      # yazi

      # Dependencies
      pandoc
      w3m
      file
      jq
      fd
      ripgrep
      poppler_utils
      ffmpegthumbnailer
      unzip
      imagemagick
      fontforge
      glow
    ];

    xdg.configFile."yazi/yazi.toml" = {
      source = ./yazi/yazi.toml;
      # Remember to include { mime = "text/markdown", run = "markdown" }
      # in the [plugin].previewers section of ./yazi.toml, before the text/* rule.
    };

    # Manage theme file
    xdg.configFile."yazi/theme.toml" = {
      source = ./yazi/theme.toml;
    };

    # Manage keymap if desired (ensure source file exists)
    xdg.configFile."yazi/keymap.toml" = {
      source = ./yazi/keymap.toml;
    };

    # Manage syntax highlighting theme if needed by previewers (like bat used internally)
    xdg.configFile."yazi/catppuccin-mocha.tmTheme" = {
      source = ./bat/catppuccin-mocha.tmTheme;
    };

    # Ensure the plugins directory exists declaratively
    xdg.configFile."yazi/plugins" = {
      # Using source = ./. here is a simple way if the source dir only contains plugins
      # Otherwise, create an empty directory if needed:
      # source = pkgs.runCommand "yazi-plugins-dir" {} '' mkdir -p $out '';
      # If you have other files like get_plugins.sh in ./yazi/ that you DON'T want copied:
      source = (pkgs.runCommand "yazi-plugins-dir-empty" { } ''mkdir -p $out'');
      recursive = true; # Needed if creating the directory itself
    };

    # Link the markdown preview script into the plugins directory
    xdg.configFile."yazi/plugins/markdown.sh" = {
      source = markdownPreviewScript; # Points to the script created by writeShellScript
      executable = true; # Make the symlink (or file) executable
    };
  };
}
