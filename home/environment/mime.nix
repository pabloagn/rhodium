{ userExtras, userPreferences, ... }:

let
  appsData = userExtras.appsData;
  profilesData = userExtras.profilesData;
  preferredApps = userPreferences.apps;

  # TODO: Obviously we need to make this dynamic
  userEditor = "rh-editors-editor-instance";
  userBrowser = "rh-firefox-personal";
  audio = preferredApps.audioPlayer or "clementine";
  image = "rh-viewers-image-viewer";
  pdf = preferredApps.pdfViewer or "org.pwmt.zathura.desktop";
  video = preferredApps.videoPlayer or "mpv";

in
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {

      # General
      "application/pdf" = [ "${pdf}.desktop" ];
      "application/x-extension-htm" = [ "${userBrowser}.desktop" ];
      "application/x-extension-html" = [ "${userBrowser}.desktop" ];
      "application/x-extension-shtml" = [ "${userBrowser}.desktop" ];
      "application/x-extension-xht" = [ "${userBrowser}.desktop" ];
      "application/x-extension-xhtml" = [ "${userBrowser}.desktop" ];
      "application/x-zerosize" = [ "${userEditor}.desktop" ];
      "application/xhtml+xml" = [ "${userBrowser}.desktop" ];
      "audio/flac" = [ "${audio}.desktop" ];
      "audio/mp3" = [ "${audio}.desktop" ];
      "audio/mp4" = [ "${audio}.desktop" ];
      "audio/mpeg" = [ "${audio}.desktop" ];
      "audio/ogg" = [ "${audio}.desktop" ];
      "audio/x-m4a" = [ "${audio}.desktop" ];
      "audio/x-wav" = [ "${audio}.desktop" ];
      "image/bmp" = [ "${image}.desktop" ];
      "image/gif" = [ "${image}.desktop" ];
      "image/jpeg" = [ "${image}.desktop" ];
      "image/png" = [ "${image}.desktop" ];
      "image/svg+xml" = [ "${image}.desktop" ];
      "image/tiff" = [ "${image}.desktop" ];
      "image/webp" = [ "${image}.desktop" ];
      "text/html" = [ "${userBrowser}.desktop" ];
      "text/plain" = [ "${userEditor}.desktop" ];
      "video/avi" = [ "${video}.desktop" ];
      "video/mp4" = [ "${video}.desktop" ];
      "video/ogg" = [ "${video}.desktop" ];
      "video/webm" = [ "${video}.desktop" ];
      "video/x-matroska" = [ "${video}.desktop" ];
      "video/x-msvideo" = [ "${video}.desktop" ];
      "x-scheme-handler/chrome" = [ "${userBrowser}.desktop" ];
      "x-scheme-handler/http" = [ "${userBrowser}.desktop" ];
      "x-scheme-handler/https" = [ "${userBrowser}.desktop" ];

      # Programming Languages - All use editor
      "text/x-shellscript" = [ "${userEditor}.desktop" ];
      "text/x-script.python" = [ "${userEditor}.desktop" ];
      "text/x-script.bash" = [ "${userEditor}.desktop" ];
      "text/x-c" = [ "${userEditor}.desktop" ];
      "text/x-c++" = [ "${userEditor}.desktop" ];
      "text/x-java" = [ "${userEditor}.desktop" ];
      "text/x-java-source" = [ "${userEditor}.desktop" ];
      "text/x-pascal" = [ "${userEditor}.desktop" ];
      "text/x-script.perl" = [ "${userEditor}.desktop" ];
      "text/x-script.ruby" = [ "${userEditor}.desktop" ];
      "text/x-rust" = [ "${userEditor}.desktop" ];
      "text/x-haskell" = [ "${userEditor}.desktop" ];
      "text/x-literate-haskell" = [ "${userEditor}.desktop" ];
      "text/x-lua" = [ "${userEditor}.desktop" ];
      "text/x-php" = [ "${userEditor}.desktop" ];
      "text/x-ruby" = [ "${userEditor}.desktop" ];
      "text/x-python" = [ "${userEditor}.desktop" ];
      "text/x-R" = [ "${userEditor}.desktop" ];
      "text/x-scala" = [ "${userEditor}.desktop" ];
      "text/x-scheme" = [ "${userEditor}.desktop" ];
      "text/x-typescript" = [ "${userEditor}.desktop" ];
      "text/javascript" = [ "${userEditor}.desktop" ];
      "text/x-csrc" = [ "${userEditor}.desktop" ];
      "text/x-chdr" = [ "${userEditor}.desktop" ];
      "text/x-c++src" = [ "${userEditor}.desktop" ];
      "text/x-c++hdr" = [ "${userEditor}.desktop" ];
      "text/x-csharp" = [ "${userEditor}.desktop" ];
      "text/x-go" = [ "${userEditor}.desktop" ];
      "text/x-fortran" = [ "${userEditor}.desktop" ];
      "text/x-erlang" = [ "${userEditor}.desktop" ];
      "text/x-elixir" = [ "${userEditor}.desktop" ];
      "text/x-diff" = [ "${userEditor}.desktop" ];
      "text/x-dart" = [ "${userEditor}.desktop" ];
      "text/x-cmake" = [ "${userEditor}.desktop" ];
      "text/x-clojure" = [ "${userEditor}.desktop" ];

      # Config Files
      "application/json" = [ "${userEditor}.desktop" ];
      "application/toml" = [ "${userEditor}.desktop" ];
      "application/x-yaml" = [ "${userEditor}.desktop" ];
      "text/yaml" = [ "${userEditor}.desktop" ];
      "text/x-ini" = [ "${userEditor}.desktop" ];
      "application/xml" = [ "${userEditor}.desktop" ];
      "text/xml" = [ "${userEditor}.desktop" ];
      "application/x-wine-extension-ini" = [ "${userEditor}.desktop" ];
      "application/vnd.coffeescript" = [ "${userEditor}.desktop" ];
      "application/x-ndjson" = [ "${userEditor}.desktop" ];
      "application/ld+json" = [ "${userEditor}.desktop" ];

      # Web Development
      "text/css" = [ "${userEditor}.desktop" ];
      "text/scss" = [ "${userEditor}.desktop" ];
      "text/sass" = [ "${userEditor}.desktop" ];
      "text/less" = [ "${userEditor}.desktop" ];
      "application/javascript" = [ "${userEditor}.desktop" ];
      "application/typescript" = [ "${userEditor}.desktop" ];
      "application/x-typescript" = [ "${userEditor}.desktop" ];
      "application/x-httpd-php" = [ "${userEditor}.desktop" ];
      "application/x-php" = [ "${userEditor}.desktop" ];
      "application/jsx" = [ "${userEditor}.desktop" ];
      "application/x-jsx" = [ "${userEditor}.desktop" ];
      "application/tsx" = [ "${userEditor}.desktop" ];
      "application/x-tsx" = [ "${userEditor}.desktop" ];
      "application/graphql" = [ "${userEditor}.desktop" ];
      "application/wasm" = [ "${userEditor}.desktop" ];

      # Documentation & Markup
      "text/markdown" = [ "${userEditor}.desktop" ];
      "text/x-markdown" = [ "${userEditor}.desktop" ];
      "text/x-rst" = [ "${userEditor}.desktop" ];
      "text/x-tex" = [ "${userEditor}.desktop" ];
      "text/x-latex" = [ "${userEditor}.desktop" ];
      "application/x-tex" = [ "${userEditor}.desktop" ];
      "application/x-latex" = [ "${userEditor}.desktop" ];
      "text/asciidoc" = [ "${userEditor}.desktop" ];
      "text/x-org" = [ "${userEditor}.desktop" ];
      "text/x-textile" = [ "${userEditor}.desktop" ];
      "application/x-rmarkdown" = [ "${userEditor}.desktop" ];
      "application/x-jupyter-notebook+json" = [ "${userEditor}.desktop" ];

      # Database & Data
      "application/sql" = [ "${userEditor}.desktop" ];
      "text/x-sql" = [ "${userEditor}.desktop" ];
      "text/csv" = [ "${userEditor}.desktop" ];
      "text/tab-separated-values" = [ "${userEditor}.desktop" ];
      "application/vnd.sqlite3" = [ "${userEditor}.desktop" ];
      "application/x-sqlite3" = [ "${userEditor}.desktop" ];

      # Shell/System
      "application/x-sh" = [ "${userEditor}.desktop" ];
      "application/x-shellscript" = [ "${userEditor}.desktop" ];
      "application/x-desktop" = [ "${userEditor}.desktop" ];
      "application/x-executable" = [ "${userEditor}.desktop" ];
      "text/x-makefile" = [ "${userEditor}.desktop" ];
      "text/x-meson" = [ "${userEditor}.desktop" ];
      "text/x-cmake-project" = [ "${userEditor}.desktop" ];
      "application/x-perl" = [ "${userEditor}.desktop" ];
      "application/x-ruby" = [ "${userEditor}.desktop" ];
      "application/x-python" = [ "${userEditor}.desktop" ];
      "application/x-bash" = [ "${userEditor}.desktop" ];
      "application/x-zsh" = [ "${userEditor}.desktop" ];
      "application/x-fish" = [ "${userEditor}.desktop" ];
      "application/x-systemd-unit" = [ "${userEditor}.desktop" ];

      # Version Control
      "text/x-patch" = [ "${userEditor}.desktop" ];
      "text/x-git-config" = [ "${userEditor}.desktop" ];
      "text/x-hg-config" = [ "${userEditor}.desktop" ];
      "text/x-svn-config" = [ "${userEditor}.desktop" ];

      # DevOps & Infrastructure
      "application/x-docker" = [ "${userEditor}.desktop" ];
      "text/x-dockerfile" = [ "${userEditor}.desktop" ];
      "application/x-terraform" = [ "${userEditor}.desktop" ];
      "application/x-ansible" = [ "${userEditor}.desktop" ];
      "application/x-vagrant-vagrantfile" = [ "${userEditor}.desktop" ];
      "application/x-jenkins" = [ "${userEditor}.desktop" ];
      "application/vnd.kubernetes.helm.chart" = [ "${userEditor}.desktop" ];
      "text/x-nginx-conf" = [ "${userEditor}.desktop" ];
      "text/x-apache-conf" = [ "${userEditor}.desktop" ];

      # Mobile Development
      "application/x-kotlin" = [ "${userEditor}.desktop" ];
      "text/x-kotlin" = [ "${userEditor}.desktop" ];
      "application/x-swift" = [ "${userEditor}.desktop" ];
      "text/x-swift" = [ "${userEditor}.desktop" ];
      "application/x-objective-c" = [ "${userEditor}.desktop" ];
      "text/x-objective-c" = [ "${userEditor}.desktop" ];

      # Game Development
      "application/x-godot-resource" = [ "${userEditor}.desktop" ];
      "application/x-unity3d-scene" = [ "${userEditor}.desktop" ];
      "application/x-unreal-blueprint" = [ "${userEditor}.desktop" ];

      # Special formats
      "application/x-ipynb+json" = [ "${userEditor}.desktop" ];
      "application/vnd.groove-tool-template" = [ "${userEditor}.desktop" ];
      "application/x-kicad-pcb" = [ "${userEditor}.desktop" ];
      "application/x-kicad-schematic" = [ "${userEditor}.desktop" ];

      # Nix-specific
      "text/x-nix" = [ "${userEditor}.desktop" ];
      "application/x-nix-package" = [ "${userEditor}.desktop" ];

      # Logs and debugging
      "text/x-log" = [ "${userEditor}.desktop" ];
      "application/x-coredump" = [ "${userEditor}.desktop" ];

      # Any other text-based format
      "text/x-generic" = [ "${userEditor}.desktop" ];
      "application/octet-stream" = [ "${userEditor}.desktop" ];
    };
  };
}
