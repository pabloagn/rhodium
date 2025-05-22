# home/apps/terminal/utils/navigation/yazi.nix

{ lib, config, pkgs, pkgs-unstable, _haumea, rhodiumLib, inputs, ... }:

with lib;
let
  categoryName = _haumea.name;
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  yaziConfigBaseDir = ./${categoryName};

  markdownPreviewScript = pkgs.writeShellScript "yazi-markdown-preview" ''
    #!${pkgs.runtimeShell}
    if ! command -v pandoc >/dev/null 2>&1; then
      echo "Preview Error: 'pandoc' command not found." >&2
      exit 1
    fi
    if ! command -v w3m >/dev/null 2>&1; then
      echo "Preview Error: 'w3m' command not found." >&2
      exit 1
    fi
    FILE_PATH="$1"
    WIDTH="''${YACOL:-80}"
    (${pkgs.pandoc}/bin/pandoc -f markdown -t html --standalone "$FILE_PATH" 2>&1 | ${pkgs.w3m}/bin/w3m -T text/html -dump -cols "$WIDTH")
    exit $?
  '';
in
{
  options = setAttrByPath _haumea.configPath (
    rhodiumLib.mkAppModuleOptions {
      appName = categoryName;
      appDescription = "${rhodiumLib.metadata.appName}'s ${categoryName} configuration";
      hasDesktop = true;
    }
  );

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = with pkgs; [
      (pkgs-unstable.yazi or pkgs.yazi)
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

    xdg.configFile."yazi/yazi.toml".source = yaziConfigBaseDir + "/yazi.toml";
    xdg.configFile."yazi/theme.toml".source = yaziConfigBaseDir + "/theme.toml";
    xdg.configFile."yazi/keymap.toml".source = yaziConfigBaseDir + "/keymap.toml";
    xdg.configFile."yazi/catppuccin-mocha.tmTheme".source = yaziConfigBaseDir + "/bat/catppuccin-mocha.tmTheme";
    xdg.configFile."yazi/plugins".source = (pkgs.runCommand "yazi-plugins-dir-empty" { } ''mkdir -p $out'');
    xdg.configFile."yazi/plugins/markdown.sh" = {
      source = markdownPreviewScript;
      executable = true;
    };
  };
}
