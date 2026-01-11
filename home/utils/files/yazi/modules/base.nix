{ ... }:
{
  # --- General ---
  input = {
    cd_offset = [
      0
      2
      50
      3
    ];
    cd_origin = "top-center";
    cd_title = "Change directory:";
    create_offset = [
      0
      2
      50
      3
    ];
    create_origin = "top-center";
    create_title = [
      "Create:"
      "Create:"
    ];
    cursor_blink = false;
    delete_offset = [
      0
      2
      50
      3
    ];
    delete_origin = "top-center";
    delete_title = "Delete {n} selected file{s} permanently? (y/N)";
    filter_offset = [
      0
      2
      50
      3
    ];
    filter_origin = "top-center";
    filter_title = "Filter:";
    find_offset = [
      0
      2
      50
      3
    ];
    find_origin = "top-center";
    find_title = [
      "Find next:"
      "Find previous:"
    ];
    overwrite_offset = [
      0
      2
      50
      3
    ];
    overwrite_origin = "top-center";
    overwrite_title = "Overwrite an existing file? (y/N)";
    quit_offset = [
      0
      2
      50
      3
    ];
    quit_origin = "top-center";
    quit_title = "{n} task{s} running, sure to quit? (y/N)";
    rename_offset = [
      0
      1
      50
      3
    ];
    rename_origin = "hovered";
    rename_title = "Rename:";
    search_offset = [
      0
      2
      50
      3
    ];
    search_origin = "top-center";
    search_title = "Search via {n}:";
    shell_offset = [
      0
      2
      50
      3
    ];
    shell_origin = "top-center";
    shell_title = [
      "Shell:"
      "Shell (block):"
    ];
    trash_offset = [
      0
      2
      50
      3
    ];
    trash_origin = "top-center";
    trash_title = "Move {n} selected file{s} to trash? (y/N)";
  };

  mgr = {
    linemode = "none";
    mouse_events = [
      "click"
      "scroll"
      "touch"
      "move"
      "drag"
    ];
    ratio = [
      1
      4
      3
    ];
    scrolloff = 5;
    show_hidden = false;
    show_symlink = true;
    sort_by = "alphabetical";
    sort_dir_first = true;
    sort_reverse = false;
    sort_sensitive = false;
    sort_translit = false;
  };

  select = {
    open_offset = [
      0
      1
      50
      7
    ];
    open_origin = "hovered";
    open_title = "Open with:";
  };

  preview = {
    cache_dir = "\$XDG_CACHE_HOME/yazi";
    image_filter = "nearest";
    image_quality = 70;
    max_width = 2000;
    sixel_fraction = 15;
    tab_size = 2;
    ueberzug_offset = [
      0
      0
      0
      0
    ];
    ueberzug_scale = 1;
    image_delay = 20;
  };

  tasks = {
    bizarre_retry = 5;
    image_alloc = 536870912;
    image_bound = [
      0
      0
    ];
    macro_workers = 25;
    micro_workers = 10;
    suppress_preload = false;
  };

  which = {
    sort_by = "none";
    sort_reverse = false;
    sort_sensitive = false;
    sort_translit = false;
  };

  log = {
    enabled = false;
  };

  # --- Opener Definitions ---
  opener = {
    # Code Editors
    edit = [
      {
        desc = "Edit with \$EDITOR";
        for = "unix";
        block = true;
        run = "\${EDITOR:=nvim} \"$@\"";
      }
    ];

    edit-helix = [
      {
        desc = "Edit with Helix";
        for = "unix";
        block = true;
        run = "hx \"$@\"";
      }
    ];

    edit-zed = [
      {
        desc = "Edit with Zed";
        for = "unix";
        block = true;
        run = "zeditor \"$@\"";
      }
    ];

    edit-nano = [
      {
        desc = "Edit with Nano";
        for = "unix";
        block = true;
        run = "nano \"$@\"";
      }
    ];

    edit-emacs = [
      {
        desc = "Edit with Emacs";
        for = "unix";
        block = true;
        run = "emacs \"$@\"";
      }
    ];

    # Web Browsers (with profiles & new window flags)
    browser-personal = [
      {
        desc = "Firefox (Personal)";
        for = "unix";
        run = "firefox -p Personal -new-window \"$@\"";
      }
    ];

    browser-work = [
      {
        desc = "Firefox (SolenoidLabs)";
        for = "unix";
        run = "firefox -p SolenoidLabs -new-window \"$@\"";
      }
    ];

    browser-incognito = [
      {
        desc = "Firefox (Private)";
        for = "unix";
        run = "firefox -p Personal --private-window \"$@\"";
      }
    ];

    libreoffice-calc = [
      {
        desc = "LibreOffice Calc (Spreadsheets)";
        for = "unix";
        orphan = true;
        run = "libreoffice --calc \"$@\"";
      }
    ];

    libreoffice-writer = [
      {
        desc = "LibreOffice Writer (Documents)";
        for = "unix";
        orphan = true;
        run = "libreoffice --writer \"$@\"";
      }
    ];

    libreoffice-impress = [
      {
        desc = "LibreOffice Impress (Slides)";
        for = "unix";
        orphan = true;
        run = "libreoffice --impress \"$@\"";
      }
    ];

    libreoffice-draw = [
      {
        desc = "LibreOffice Draw (Diagrams)";
        for = "unix";
        orphan = true;
        run = "libreoffice --draw \"$@\"";
      }
    ];

    libreoffice-base = [
      {
        desc = "LibreOffice Base (Databases)";
        for = "unix";
        orphan = true;
        run = "libreoffice --base \"$@\"";
      }
    ];

    libreoffice-math = [
      {
        desc = "LibreOffice Math (Formulas)";
        for = "unix";
        orphan = true;
        run = "libreoffice --math \"$@\"";
      }
    ];

    # Image Viewers/Editors
    open = [
      {
        desc = "System default";
        for = "linux";
        orphan = true;
        run = "xdg-open \"$1\"";
      }
    ];

    imv = [
      {
        desc = "imv (direct)";
        for = "unix";
        orphan = true;
        run = "imv \"$@\"";
      }
    ];

    oculante = [
      {
        desc = "oculante (direct)";
        for = "unix";
        orphan = true;
        run = "oculante \"$@\"";
      }
    ];

    swayimg = [
      {
        desc = "swayimg (direct)";
        for = "unix";
        orphan = true;
        run = "swayimg \"$@\"";
      }
    ];

    imagemagick = [
      {
        desc = "ImageMagick (display)";
        for = "unix";
        orphan = true;
        run = "display \"$@\"";
      }
    ];

    gimp = [
      {
        desc = "GIMP";
        for = "unix";
        orphan = true;
        run = "gimp \"$@\"";
      }
    ];

    # File Managers
    thunar = [
      {
        desc = "Open in Thunar";
        for = "linux";
        orphan = true;
        run = "thunar \"$@\"";
      }
    ];

    reveal = [
      {
        desc = "Show in file manager";
        for = "linux";
        orphan = true;
        run = "xdg-open \"$(dirname \"$1\")\"";
      }
    ];

    # Media Players
    play = [
      {
        desc = "Play with mpv";
        for = "unix";
        orphan = true;
        run = "mpv --force-window \"$@\"";
      }
    ];

    vlc = [
      {
        desc = "Play with VLC";
        for = "unix";
        orphan = true;
        run = "vlc \"$@\"";
      }
    ];

    # --- Archive Tools ---
    extract = [
      {
        desc = "Extract here";
        for = "unix";
        run = "ya pub extract --list \"$@\"";
      }
    ];

    # --- PDF Viewers ---
    okular = [
      {
        desc = "Okular (Full-featured)";
        for = "unix";
        orphan = true;
        run = "okular \"$@\"";
      }
    ];

    zathura = [
      {
        desc = "Zathura (Vim-like, fast)";
        for = "unix";
        orphan = true;
        run = "zathura \"$@\"";
      }
    ];

    # --- Drag and Drop ---
    dragon = [
      {
        desc = "Drag files (dragon-drop)";
        for = "unix";
        orphan = true;
        run = "dragon -x -i -T \"$@\"";
      }
    ];
  };

  # --- Open Rules ---
  open = {
    rules = [
      # --- Directories ---
      {
        url = "*/";
        use = [
          "edit"
          "edit-helix"
          "edit-zed"
          "edit-nano"
          "edit-emacs"
          "thunar"
          "reveal"
        ];
      }

      # --- Code Files (by extension) ---
      {
        url = "*.{js,jsx,ts,tsx,py,rs,go,c,cpp,h,hpp,java,rb,php,lua,vim,sh,bash,zsh,fish,nu,Xresources,json,yaml,yml,toml,ini,conf,cfg}";
        use = [
          "edit"
          "edit-helix"
          "edit-zed"
          "edit-nano"
          "edit-emacs"
          "reveal"
        ];
      }
      {
        url = "*.{md,markdown,rst,tex}";
        use = [
          "edit"
          "edit-helix"
          "edit-zed"
          "edit-nano"
          "edit-emacs"
          "reveal"
        ];
      }
      {
        url = "*.{css,scss,sass,less}";
        use = [
          "edit"
          "edit-helix"
          "edit-zed"
          "edit-nano"
          "edit-emacs"
          "reveal"
        ];
      }
      {
        url = "*.{xml,sql,graphql,proto}";
        use = [
          "edit"
          "edit-helix"
          "edit-zed"
          "edit-nano"
          "edit-emacs"
          "reveal"
        ];
      }

      # --- HTML Files (special case with browsers) ---
      {
        url = "*.{html,htm,xhtml}";
        use = [
          "edit"
          "edit-helix"
          "edit-zed"
          "edit-nano"
          "edit-emacs"
          "browser-personal"
          "browser-work"
          "browser-incognito"
          "reveal"
        ];
      }

      # --- SVG Files (special case - both image and code) ---
      {
        url = "*.svg";
        use = [
          "open"
          "imagemagick"
          "gimp"
          "edit"
          "edit-helix"
          "edit-zed"
          "edit-nano"
          "edit-emacs"
          "reveal"
        ];
      }

      # --- Images (no edit options) ---
      {
        url = "*.{jpg,jpeg,png,gif,webp,bmp,ico,tiff,psd,avif,heic,heif}";
        use = [
          "open"
          "oculante"
          "swayimg"
          "imv"
          "imagemagick"
          "gimp"
          "reveal"
        ];
      }

      # --- Code Files (by MIME type) ---
      {
        mime = "text/*";
        use = [
          "edit"
          "edit-helix"
          "edit-zed"
          "edit-nano"
          "edit-emacs"
          "reveal"
        ];
      }
      {
        mime = "*/javascript";
        use = [
          "edit"
          "edit-helix"
          "edit-zed"
          "edit-nano"
          "edit-emacs"
          "reveal"
        ];
      }
      {
        mime = "application/{json,x-ndjson}";
        use = [
          "edit"
          "edit-helix"
          "edit-zed"
          "edit-nano"
          "edit-emacs"
          "reveal"
        ];
      }

      # --- Media Files ---
      {
        mime = "image/*";
        use = [
          "open"
          "imv"
          "oculante"
          "swayimg"
          "imagemagick"
          "gimp"
          "reveal"
        ];
      }
      {
        mime = "{audio,video}/*";
        use = [
          "play"
          "vlc"
          "reveal"
        ];
      }

      # --- Archives ---
      {
        mime = "application/{,g}zip";
        use = [
          "extract"
          "reveal"
        ];
      }
      {
        mime = "application/x-{tar,bzip*,7z-compressed,xz,rar}";
        use = [
          "extract"
          "reveal"
        ];
      }

      # --- PDFs ---
      {
        mime = "application/pdf";
        use = [
          "okular"
          "zathura"
          "libreoffice-draw"
          "open"
          "reveal"
        ];
      }
      {
        url = "*.pdf";
        use = [
          "okular"
          "zathura"
          "libreoffice-draw"
          "open"
          "reveal"
        ];
      }

      # --- Tabular Data Files ---
      {
        url = "*.{csv,tsv,tab,psv}";
        use = [
          "libreoffice-calc"
          "edit"
          "edit-helix"
          "edit-zed"
          "edit-nano"
          "edit-emacs"
          "reveal"
        ];
      }
      # Parquet files (data engineering)
      {
        url = "*.parquet";
        use = [
          "edit"
          "reveal"
        ];
      }
      # JSON/NDJSON files (structured data)
      {
        url = "*.{json,ndjson,jsonl}";
        use = [
          "edit"
          "edit-helix"
          "edit-zed"
          "edit-nano"
          "edit-emacs"
          "browser-personal"
          "reveal"
        ];
      }

      # --- Text Files ---
      {
        url = "*.{txt,text,log,md,markdown,rst,tex}";
        use = [
          "edit"
          "edit-helix"
          "edit-zed"
          "edit-nano"
          "edit-emacs"
          "reveal"
        ];
      }

      # --- Office ---
      # Documents
      {
        url = "*.{odt,doc,docx,rtf}";
        use = [
          "libreoffice-writer"
          "onlyoffice"
          "reveal"
        ];
      }
      {
        mime = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
        use = [
          "libreoffice-writer"
          "onlyoffice"
          "reveal"
        ];
      }
      {
        mime = "application/msword";
        use = [
          "libreoffice-writer"
          "onlyoffice"
          "reveal"
        ];
      }
      {
        mime = "application/rtf";
        use = [
          "libreoffice-writer"
          "onlyoffice"
          "reveal"
        ];
      }

      # Spreadsheets
      {
        url = "*.{xls,xlsx,xlsm,xlsb,ods}";
        use = [
          "libreoffice-calc"
          "onlyoffice"
          "reveal"
        ];
      }
      {
        mime = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
        use = [
          "libreoffice-calc"
          "onlyoffice"
          "reveal"
        ];
      }
      {
        mime = "application/vnd.ms-excel";
        use = [
          "libreoffice-calc"
          "onlyoffice"
          "reveal"
        ];
      }
      {
        mime = "application/vnd.oasis.opendocument.spreadsheet";
        use = [
          "libreoffice-calc"
          "onlyoffice"
          "reveal"
        ];
      }

      # Presentations
      {
        url = "*.{odp,ppt,pptx}";
        use = [
          "libreoffice-impress"
          "onlyoffice"
          "reveal"
        ];
      }
      {
        mime = "application/vnd.ms-powerpoint";
        use = [
          "libreoffice-impress"
          "onlyoffice"
          "reveal"
        ];
      }
      {
        mime = "application/vnd.openxmlformats-officedocument.presentationml.presentation";
        use = [
          "libreoffice-impress"
          "onlyoffice"
          "reveal"
        ];
      }
      {
        mime = "application/vnd.oasis.opendocument.presentation";
        use = [
          "libreoffice-impress"
          "onlyoffice"
          "reveal"
        ];
      }

      # Drawings
      {
        url = "*.{odg}";
        use = [
          "libreoffice-draw"
          "gimp"
          "imagemagick"
          "reveal"
        ];
      }
      # Math Formulas
      {
        url = "*.{odf}";
        use = [
          "libreoffice-math"
          "reveal"
        ];
      }

      # Libre Database Files
      {
        url = "*.{odb}";
        use = [
          "libreoffice-base"
          "reveal"
        ];
      }

      # --- Empty Files ---
      {
        mime = "inode/x-empty";
        use = [
          "edit"
          "edit-helix"
          "edit-zed"
          "edit-nano"
          "edit-emacs"
          "reveal"
        ];
      }

      # --- Catch-all Rule ---
      {
        url = "*";
        use = [
          "edit"
          "edit-helix"
          "edit-zed"
          "edit-nano"
          "edit-emacs"
          "imv"
          "oculante"
          "swayimg"
          "imagemagick"
          "gimp"
          "open"
          "reveal"
        ];
      }
    ];
  };

  # ===== Plugin Configurations =====
  plugin = {
    # --- Preloaders ---
    preloaders = [
      {
        mime = "image/{avif,heic,jxl,svg+xml}";
        run = "magick";
      }

      {
        mime = "image/*";
        run = "image";
      }

      {
        mime = "video/*";
        run = "video";
      }

      {
        mime = "application/pdf";
        run = "pdf";
      }

      {
        mime = "font/*";
        run = "font";
      }

      {
        mime = "application/vnd.ms-opentype";
        run = "font";
      }
    ];

    # --- Fetchers ---
    prepend_fetchers = [
      {
        id = "git";
        url = "*";
        run = "git";
      }

      {
        id = "git";
        url = "*/";
        run = "git";
      }
    ];

    # --- Previewers ---
    prepend_previewers = [
      # --- Structured Data (duckdb) ---
      {
        url = "*.csv";
        run = "duckdb";
      }
      {
        url = "*.tsv";
        run = "duckdb";
      }
      {
        url = "*.parquet";
        run = "duckdb";
      }
      {
        url = "*.db";
        run = "duckdb";
      }
      {
        url = "*.duckdb";
        run = "duckdb";
      }

      # --- Markdown (glow via piper with custom kanso style) ---
      {
        url = "*.md";
        run = "piper -- CLICOLOR_FORCE=1 glow -w=$w -s=$HOME/.config/glow/kanso.json \"$1\"";
      }
      {
        url = "*.markdown";
        run = "piper -- CLICOLOR_FORCE=1 glow -w=$w -s=$HOME/.config/glow/kanso.json \"$1\"";
      }

      # --- Archives (ouch) ---
      {
        mime = "application/*zip";
        run = "ouch";
      }
      {
        mime = "application/x-tar";
        run = "ouch";
      }
      {
        mime = "application/x-bzip2";
        run = "ouch";
      }
      {
        mime = "application/x-7z-compressed";
        run = "ouch";
      }
      {
        mime = "application/x-rar";
        run = "ouch";
      }
      {
        mime = "application/x-xz";
        run = "ouch";
      }
      {
        mime = "application/xz";
        run = "ouch";
      }
    ];

    # --- Preloaders (for caching) ---
    prepend_preloaders = [
      {
        url = "*.csv";
        run = "duckdb";
        multi = false;
      }
      {
        url = "*.tsv";
        run = "duckdb";
        multi = false;
      }
      {
        url = "*.parquet";
        run = "duckdb";
        multi = false;
      }
    ];

    previewers = [
      {
        url = "*/";
        run = "folder";
        sync = true;
      }

      {
        mime = "text/*";
        run = "code";
      }

      {
        mime = "*/{xml,javascript,x-wine-extension-ini}";
        run = "code";
      }

      {
        mime = "application/{json,x-ndjson}";
        run = "json";
      }

      {
        mime = "image/{avif,heic,jxl,svg+xml}";
        run = "magick";
      }

      {
        mime = "image/*";
        run = "image";
      }

      {
        mime = "video/*";
        run = "video";
      }

      {
        mime = "application/pdf";
        run = "pdf";
      }

      {
        mime = "application/{,g}zip";
        run = "archive";
      }

      {
        mime = "application/x-{tar,bzip*,7z-compressed,xz,rar,iso9660-image}";
        run = "archive";
      }

      {
        mime = "font/*";
        run = "font";
      }

      {
        mime = "application/vnd.ms-opentype";
        run = "font";
      }

      {
        url = "*";
        run = "file";
      }
    ];
  };

  # ===== Status Bar Components =====
  status = {
    component_left = [
      {
        format = " {} ";
        type = "mode";
      }

      {
        command = "git_branch_display";
        format = "{}";
        type = "custom";
      }

      {
        format = " {} ";
        type = "cwd";
      }
    ];

    component_middle = [
      {
        format = " {}/{} ";
        type = "position";
      }
    ];

    component_right = [
      {
        format = " {} ";
        type = "selection";
      }

      {
        format = " Tasks: {} ";
        type = "tasks";
      }
    ];
  };
}
