# home/environment/mime.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.environment.mime;
in
{
  options.rhodium.environment.mime = {
    enable = mkEnableOption "Rhodium's MIME type associations";
  };

  config = mkIf (config.rhodium.environment.enable && cfg.enable) {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {

        # General
        "application/pdf" = ["org.kde.okular.desktop"];
        "application/x-extension-htm" = ["firefox.desktop"];
        "application/x-extension-html" = ["firefox.desktop"];
        "application/x-extension-shtml" = ["firefox.desktop"];
        "application/x-extension-xht" = ["firefox.desktop"];
        "application/x-extension-xhtml" = ["firefox.desktop"];
        "application/x-zerosize" = ["editor.desktop"];
        "application/xhtml+xml" = ["firefox.desktop"];
        "audio/flac" = ["clementine.desktop"];
        "audio/mp3" = ["clementine.desktop"];
        "audio/mp4" = ["clementine.desktop"];
        "audio/mpeg" = ["clementine.desktop"];
        "audio/ogg" = ["clementine.desktop"];
        "audio/x-m4a" = ["clementine.desktop"];
        "audio/x-wav" = ["clementine.desktop"];
        "image/bmp" = ["feh-image-viewer.desktop"];
        "image/gif" = ["feh-image-viewer.desktop"];
        "image/jpeg" = ["feh-image-viewer.desktop"];
        "image/png" = ["feh-image-viewer.desktop"];
        "image/svg+xml" = ["feh-image-viewer.desktop"];
        "image/tiff" = ["feh-image-viewer.desktop"];
        "image/webp" = ["feh-image-viewer.desktop"];
        "text/html" = ["firefox.desktop"];
        "text/plain" = ["editor.desktop"];
        "video/avi" = ["mpv.desktop"];
        "video/mp4" = ["mpv.desktop"];
        "video/ogg" = ["mpv.desktop"];
        "video/webm" = ["mpv.desktop"];
        "video/x-matroska" = ["mpv.desktop"];
        "video/x-msvideo" = ["mpv.desktop"];
        "x-scheme-handler/chrome" = ["firefox.desktop"];
        "x-scheme-handler/http" = ["firefox.desktop"];
        "x-scheme-handler/https" = ["firefox.desktop"];

        # Programming Languages - General Text Formats
        "text/x-shellscript" = ["editor.desktop"];
        "text/x-script.python" = ["editor.desktop"];
        "text/x-script.bash" = ["editor.desktop"];
        "text/x-c" = ["editor.desktop"];
        "text/x-c++" = ["editor.desktop"];
        "text/x-java" = ["editor.desktop"];
        "text/x-java-source" = ["editor.desktop"];
        "text/x-pascal" = ["editor.desktop"];
        "text/x-script.perl" = ["editor.desktop"];
        "text/x-script.ruby" = ["editor.desktop"];
        "text/x-rust" = ["editor.desktop"];
        "text/x-haskell" = ["editor.desktop"];
        "text/x-literate-haskell" = ["editor.desktop"];
        "text/x-lua" = ["editor.desktop"];
        "text/x-php" = ["editor.desktop"];
        "text/x-ruby" = ["editor.desktop"];
        "text/x-python" = ["editor.desktop"];
        "text/x-R" = ["editor.desktop"];
        "text/x-scala" = ["editor.desktop"];
        "text/x-scheme" = ["editor.desktop"];
        "text/x-typescript" = ["editor.desktop"];
        "text/javascript" = ["editor.desktop"];
        "text/x-csrc" = ["editor.desktop"];
        "text/x-chdr" = ["editor.desktop"];
        "text/x-c++src" = ["editor.desktop"];
        "text/x-c++hdr" = ["editor.desktop"];
        "text/x-csharp" = ["editor.desktop"];
        "text/x-go" = ["editor.desktop"];
        "text/x-fortran" = ["editor.desktop"];
        "text/x-erlang" = ["editor.desktop"];
        "text/x-elixir" = ["editor.desktop"];
        "text/x-diff" = ["editor.desktop"];
        "text/x-dart" = ["editor.desktop"];
        "text/x-cmake" = ["editor.desktop"];
        "text/x-clojure" = ["editor.desktop"];

        # Config Files
        "application/json" = ["editor.desktop"];
        "application/toml" = ["editor.desktop"];
        "application/x-yaml" = ["editor.desktop"];
        "text/yaml" = ["editor.desktop"];
        "text/x-ini" = ["editor.desktop"];
        "application/xml" = ["editor.desktop"];
        "text/xml" = ["editor.desktop"];
        "application/x-wine-extension-ini" = ["editor.desktop"];
        "application/vnd.coffeescript" = ["editor.desktop"];
        "application/x-ndjson" = ["editor.desktop"];
        "application/ld+json" = ["editor.desktop"];

        # Web Development
        "text/css" = ["editor.desktop"];
        "text/scss" = ["editor.desktop"];
        "text/sass" = ["editor.desktop"];
        "text/less" = ["editor.desktop"];
        "application/javascript" = ["editor.desktop"];
        "application/typescript" = ["editor.desktop"];
        "application/x-typescript" = ["editor.desktop"];
        "application/x-httpd-php" = ["editor.desktop"];
        "application/x-php" = ["editor.desktop"];
        "application/jsx" = ["editor.desktop"];
        "application/x-jsx" = ["editor.desktop"];
        "application/tsx" = ["editor.desktop"];
        "application/x-tsx" = ["editor.desktop"];
        "application/graphql" = ["editor.desktop"];
        "application/wasm" = ["editor.desktop"];

        # Documentation & Markup
        "text/markdown" = ["editor.desktop"];
        "text/x-markdown" = ["editor.desktop"];
        "text/x-rst" = ["editor.desktop"];
        "text/x-tex" = ["editor.desktop"];
        "text/x-latex" = ["editor.desktop"];
        "application/x-tex" = ["editor.desktop"];
        "application/x-latex" = ["editor.desktop"];
        "text/asciidoc" = ["editor.desktop"];
        "text/x-org" = ["editor.desktop"];
        "text/x-textile" = ["editor.desktop"];
        "application/x-rmarkdown" = ["editor.desktop"];
        "application/x-jupyter-notebook+json" = ["editor.desktop"];

        # Database & Data
        "application/sql" = ["editor.desktop"];
        "text/x-sql" = ["editor.desktop"];
        "text/csv" = ["editor.desktop"];
        "text/tab-separated-values" = ["editor.desktop"];
        "application/vnd.sqlite3" = ["editor.desktop"];
        "application/x-sqlite3" = ["editor.desktop"];

        # Shell/System
        "application/x-sh" = ["editor.desktop"];
        "application/x-shellscript" = ["editor.desktop"];
        "application/x-desktop" = ["editor.desktop"];
        "application/x-executable" = ["editor.desktop"];
        "text/x-makefile" = ["editor.desktop"];
        "text/x-meson" = ["editor.desktop"];
        "text/x-cmake-project" = ["editor.desktop"];
        "application/x-perl" = ["editor.desktop"];
        "application/x-ruby" = ["editor.desktop"];
        "application/x-python" = ["editor.desktop"];
        "application/x-bash" = ["editor.desktop"];
        "application/x-zsh" = ["editor.desktop"];
        "application/x-fish" = ["editor.desktop"];
        "application/x-systemd-unit" = ["editor.desktop"];

        # Version Control
        "text/x-patch" = ["editor.desktop"];
        "text/x-git-config" = ["editor.desktop"];
        "text/x-hg-config" = ["editor.desktop"];
        "text/x-svn-config" = ["editor.desktop"];

        # DevOps & Infrastructure
        "application/x-docker" = ["editor.desktop"];
        "text/x-dockerfile" = ["editor.desktop"];
        "application/x-terraform" = ["editor.desktop"];
        "application/x-ansible" = ["editor.desktop"];
        "application/x-vagrant-vagrantfile" = ["editor.desktop"];
        "application/x-jenkins" = ["editor.desktop"];
        "application/vnd.kubernetes.helm.chart" = ["editor.desktop"];
        "text/x-nginx-conf" = ["editor.desktop"];
        "text/x-apache-conf" = ["editor.desktop"];

        # Mobile Development
        "application/x-kotlin" = ["editor.desktop"];
        "text/x-kotlin" = ["editor.desktop"];
        "application/x-swift" = ["editor.desktop"];
        "text/x-swift" = ["editor.desktop"];
        "application/x-objective-c" = ["editor.desktop"];
        "text/x-objective-c" = ["editor.desktop"];

        # Game Development
        "application/x-godot-resource" = ["editor.desktop"];
        "application/x-unity3d-scene" = ["editor.desktop"];
        "application/x-unreal-blueprint" = ["editor.desktop"];

        # Special formats
        "application/x-ipynb+json" = ["editor.desktop"];  # Jupyter notebooks
        "application/vnd.groove-tool-template" = ["editor.desktop"];  # Template files
        "application/x-kicad-pcb" = ["editor.desktop"];  # KiCad PCB
        "application/x-kicad-schematic" = ["editor.desktop"];  # KiCad Schematic

        # Nix-specific
        "text/x-nix" = ["editor.desktop"];
        "application/x-nix-package" = ["editor.desktop"];

        # Logs and debugging
        "text/x-log" = ["editor.desktop"];
        "application/x-coredump" = ["editor.desktop"];

        # Any other text-based format
        "text/x-generic" = ["editor.desktop"];
        "application/octet-stream" = ["editor.desktop"]; # Fallback for unknown binary files
      };
    };
  };
}

