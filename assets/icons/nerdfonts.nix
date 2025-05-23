# assets/icons/nerdfonts.nix
# Nerd Fonts character definitions for NixOS

# assets/icons/nerdfonts.nix - Nerd Font icon definitions for NixOS with code points
{
  nerdfonts = {
    # Arrows
    arrows = {}; # No Nerd Font icons for arrows from yazi config

    # Math
    math = {}; # No Nerd Font icons for math from yazi config

    # Checkboxes and status indicators
    status = {
      infoCircle = { char = ""; code = "nf-fa-F0129"; }; # nf-fa-info
      checkHealth = { char = "󰓙"; code = "nf-md-F04D9"; }; # nf-md-healing
    };

    # Weather and nature
    weather = {}; # No Nerd Font icons for weather from yazi config

    # Technology and UI
    tech = {
      android = { char = ""; code = "nf-dev-E70E"; }; # nf-dev-android
      docker = { char = "󰡨"; code = "nf-md-F0868"; }; # nf-md-docker
      ionic = { char = ""; code = "nf-dev-E7A9"; }; # nf-dev-ionic
      npm = { char = ""; code = "nf-dev-E71E"; }; # nf-dev-npm (also for yarn)
      yarn = { char = ""; code = "nf-dev-E71E"; }; # nf-dev-npm (duplicate, same character as npm)
      platformio = { char = ""; code = "nf-seti-E682"; }; # nf-seti-platformio
      vagrant = { char = ""; code = "nf-fa-F0218"; }; # nf-fa-vagrant
      dropbox = { char = ""; code = "nf-dev-E707"; }; # nf-dev-dropbox
      genericUI = { char = ""; code = "nf-fa-F02D0"; }; # nf-fa-window_maximize
      gitlab = { char = ""; code = "nf-fa-F0216"; }; # nf-fa-gitlab
      magnet = { char = ""; code = "nf-fa-F027D"; }; # nf-fa-magnet
      download = { char = ""; code = "nf-fa-F00F3"; }; # nf-fa-download
      terminal = { char = ""; code = "nf-md-F0489"; }; # nf-md-console
      firefoxExtension = { char = ""; code = "nf-dev-E786"; }; # nf-dev-mozilla (for xpi)
      qt = { char = ""; code = "nf-dev-E7A1"; }; # nf-dev-qt (for pro)
    };

    # Currency
    currency = {}; # No Nerd Font icons for currency from yazi config

    # Punctuation and typography
    typography = {
      languageGlobe = { char = ""; code = "nf-fa-F01AB"; }; # nf-fa-language (for general language/locale)
      translate = { char = "󰗊"; code = "nf-md-F05CA"; }; # nf-md-translate
      calendar = { char = ""; code = "nf-fa-F0134"; }; # nf-fa-calendar
      font = { char = ""; code = "nf-fa-F019C"; }; # nf-fa-font
      hashFingerprint = { char = "󰕥"; code = "nf-md-F0565"; }; # nf-md-fingerprint (for checksums like SHA)
    };

    # Brackets and separators
    brackets = {
      separatorOpen = { char = ""; code = "U+E0B6"; }; # nf-pl-right_half_circle_thick (from powerline) - Not explicit in yazi config text, but implied from separator_open/close values
      separatorClose = { char = ""; code = "U+E0B4"; }; # nf-pl-left_half_circle_thick (from powerline) - Not explicit in yazi config text, but implied from separator_open/close values
      whichSeparator = { char = ""; code = "U+EA9C"; }; # nf-cod-split_horizontal
    };

    # Loading indicators and progress
    loading = {}; # No Nerd Font icons for loading from yazi config

    # React and UI components
    react = {}; # No Nerd Font icons for react from yazi config, as the ones there were standard Unicode.

    # Programming Language and Development Icons
    programming = {
      javascript = { char = ""; code = "nf-dev-E60C"; }; # nf-dev-javascript
      babel = { char = ""; code = "nf-dev-E639"; }; # nf-dev-babel
      typescript = { char = ""; code = "nf-dev-E628"; }; # nf-dev-typescript
      python = { char = ""; code = "nf-dev-E606"; }; # nf-dev-python
      go = { char = ""; code = "nf-dev-E627"; }; # nf-dev-go
      c = { char = ""; code = "nf-dev-E61E"; }; # nf-dev-c (also Objective-C)
      cpp = { char = ""; code = "nf-dev-E61D"; }; # nf-dev-cplusplus
      rust = { char = ""; code = "nf-seti-E68B"; }; # nf-seti-rust
      rustLib = { char = ""; code = "nf-dev-E7A8"; }; # nf-dev-rust (specific for .rlib files)
      elixir = { char = ""; code = "nf-dev-E62D"; }; # nf-dev-elixir
      java = { char = ""; code = "nf-dev-E738"; }; # nf-dev-java
      kotlin = { char = ""; code = "nf-dev-E634"; }; # nf-dev-kotlin
      scala = { char = ""; code = "nf-dev-E737"; }; # nf-dev-scala
      swift = { char = ""; code = "nf-dev-E795"; }; # nf-dev-swift
      dart = { char = ""; code = "nf-dev-E788"; }; # nf-dev-dart
      haskell = { char = ""; code = "nf-dev-E61F"; }; # nf-dev-haskell
      lua = { char = ""; code = "nf-dev-E620"; }; # nf-dev-lua
      fsharp = { char = ""; code = "nf-dev-E7A7"; }; # nf-dev-fsharp
      nim = { char = ""; code = "nf-seti-E677"; }; # nf-seti-nim
      php = { char = ""; code = "nf-dev-E73E"; }; # nf-dev-php
      perl = { char = ""; code = "nf-dev-E769"; }; # nf-dev-perl
      rLanguage = { char = "󰟔"; code = "nf-md-F07D4"; }; # nf-md-language_r
      zig = { char = ""; code = "nf-seti-E6A9"; }; # nf-seti-zig
      groovy = { char = ""; code = "nf-dev-E775"; }; # nf-dev-groovy
      crystal = { char = ""; code = "nf-dev-E62F"; }; # nf-dev-crystal
      vala = { char = ""; code = "nf-seti-E69E"; }; # nf-seti-vala
      solidity = { char = ""; code = "nf-seti-E656"; }; # nf-seti-solidity
      huff = { char = "󰡘"; code = "nf-md-F0858"; }; # nf-md-flash
      fortran = { char = "󱈚"; code = "nf-md-F121A"; }; # nf-md-language_fortran
      tcl = { char = "󰛓"; code = "nf-md-F08D3"; }; # nf-md-language_tcl
      dlang = { char = ""; code = "nf-dev-E7AF"; }; # nf-dev-dlang
      gleam = { char = ""; code = "nf-dev-E605"; }; # nf-dev-gleam
      haxe = { char = ""; code = "nf-seti-E666"; }; # nf-seti-haxe
      mojo = { char = ""; code = "nf-md-F040C"; }; # nf-md-fire (also used for general fire icon)
      verilog = { char = "󰍛"; code = "nf-md-F037B"; }; # nf-md-chip (used for VHDL/Verilog/SystemVerilog)
      clojure = { char = ""; code = "nf-dev-E768"; }; # nf-dev-clojure
      clojureAlt = { char = ""; code = "nf-dev-E76A"; }; # nf-dev-clojure_alt (for cljs/cljd/edn)
      fennel = { char = ""; code = "nf-seti-E6AF"; }; # nf-seti-fennel
      schemeLisp = { char = "󰘧"; code = "nf-md-F0627"; }; # nf-md-lisp (used for Scheme/Lisp)
      standardML = { char = "λ"; code = "U+03BB"; }; # GREEK SMALL LETTER LAMBDA (from yazi, but standard unicode, kept here for consistency of Nerd Font-related programming category)
      hurl = { char = ""; code = "nf-fa-F00EC"; }; # nf-fa-download (reused icon for Hurl language)
      azureBicep = { char = ""; code = "nf-dev-E63B"; }; # nf-dev-azure
      graphviz = { char = "󱁉"; code = "nf-md-F1049"; }; # nf-md-graph_outline
      drlRules = { char = ""; code = "nf-fae-E88C"; }; # nf-fae-cogs_drifting (for DRL rules files)
      cuda = { char = ""; code = "nf-seti-E64B"; }; # nf-seti-cuda
      prisma = { char = ""; code = "nf-seti-E684"; }; # nf-seti-prisma
      powershell = { char = "󰨊"; code = "nf-md-F0A0A"; }; # nf-md-powershell
      ruby = { char = ""; code = "nf-dev-E791"; }; # nf-dev-ruby
      headerFile = { char = ""; code = "nf-fa-F01FD"; }; # nf-fa-file_code_o
      shader = { char = ""; code = "nf-seti-E6AC"; }; # nf-seti-shaderlab
      prettier = { char = ""; code = "nf-seti-E6B2"; }; # nf-seti-prettier
      eslint = { char = ""; code = "nf-seti-E655"; }; # nf-seti-eslint
      commitlint = { char = "󰜘"; code = "nf-md-F0718"; }; # nf-md-format_paint
      testFile = { char = ""; code = "nf-md-F0499"; }; # nf-md-flask (generic for test files like .spec.js)
      nodejs = { char = ""; code = "nf-dev-E718"; }; # nf-dev-nodejs
    };

    # File System and Generic File Icons
    files = {
      text = { char = "󰈙"; code = "nf-md-F021B"; }; # nf-md-file_document_outline
      log = { char = "󰌱"; code = "nf-md-F0331"; }; # nf-md-note_text_outline
      license = { char = ""; code = "nf-dev-E60A"; }; # nf-dev-license
      envFile = { char = ""; code = "nf-md-F0462"; }; # nf-md-application_brackets_outline
      json = { char = ""; code = "nf-dev-E60B"; }; # nf-dev-json (also for json5, jsonc, webmanifest)
      genericConfig = { char = ""; code = "nf-dev-E615"; }; # nf-dev-terminal (used for many config files: ini, yaml, .bashrc etc.)
      editorConfig = { char = ""; code = "nf-seti-E652"; }; # nf-seti-editorconfig
      lockFile = { char = ""; code = "nf-seti-E672"; }; # nf-seti-lock
      binary = { char = ""; code = "nf-cod-EB68"; }; # nf-cod-file_binary (for bin, elf, exe, dll, lib, so)
      backup = { char = "󰁯"; code = "nf-md-F006F"; }; # nf-md-backup_restore (for .bak)
      database = { char = ""; code = "nf-dev-E706"; }; # nf-dev-database (for sql, sqlite, db, dump)
      hexFile = { char = ""; code = "nf-seti-E667"; }; # nf-seti-hex
      archive = { char = ""; code = "nf-md-F0450"; }; # nf-md-file_zip_outline (for zip, tar, gz, bz2, xz, rar, 7z, zst)
      diskImage = { char = ""; code = "nf-fa-E87A"; }; # nf-fa-hdd_o (for iso, img)
      rpmPackage = { char = "󰣇"; code = "nf-md-F08C7"; }; # nf-md-package_variant_closed
      package = { char = ""; code = "nf-md-F0487"; }; # nf-md-package (for godot .pck)
      diff = { char = ""; code = "nf-dev-E728"; }; # nf-dev-git_compare (for diff, patch)
      fontFile = { char = ""; code = "nf-fa-F019C"; }; # nf-fa-font (for ttf, otf, woff, woff2, flf, flc, lff)
      xml = { char = "󰗀"; code = "nf-md-F05C0"; }; # nf-md-xml
      mailMap = { char = "󰊢"; code = "nf-md-F0262"; }; # nf-md-mail (for mailmap)
    };

    # OS and Environment Configurations
    osAndEnvironments = {
      apple = { char = ""; code = "nf-fa-F027C"; }; # nf-fa-apple
      linuxConfig = { char = ""; code = "nf-linux-F0369"; }; # nf-linux-linux (general linux config, xinitrc, xsession, Xresources, Xauthority)
      archLinux = { char = ""; code = "nf-linux-F0303"; }; # nf-linux-archlinux (for PKGBUILD)
      tmux = { char = ""; code = "nf-custom-EFD8"; }; # nf-custom-tmux
      shell = { char = ""; code = "nf-dev-E7A5"; }; # nf-dev-terminal (for sh, bash, zsh, csh, ksh, fish)
      desktop = { char = ""; code = "nf-fa-F0108"; }; # nf-fa-desktop (for .desktop files)
      kdeConfig = { char = ""; code = "nf-linux-F0373"; }; # nf-linux-kde (for kdeglobals, kalgebrarc, cantorrc)
      lxdeConfig = { char = ""; code = "nf-linux-F0363"; }; # nf-linux-lxde (for lxde-rc.xml)
      lxqtConfig = { char = ""; code = "nf-linux-F0364"; }; # nf-linux-lxqt (for lxqt.conf)
      jwmConfig = { char = ""; code = "nf-fa-F035B"; }; # nf-fa-terminal (for jwmrc)
      dconfConfig = { char = ""; code = "nf-fa-F0361"; }; # nf-fa-cubes (for dconf)
      gtkConfig = { char = ""; code = "nf-linux-F0362"; }; # nf-linux-gtk (for gtkrc, .gtkrc-2.0, gresource)
      nixos = { char = ""; code = "nf-linux-F0313"; }; # nf-linux-nixos
      xmonadConfig = { char = ""; code = "nf-fa-F035E"; }; # nf-fa-square_o (for xmonad.hs, xmobarrc)
      hyprlandConfig = { char = ""; code = "nf-fa-F0359"; }; # nf-fa-square (for hyprland.conf, hypridle.conf, hyprlock.conf)
      i3Config = { char = ""; code = "nf-fa-F035A"; }; # nf-fa-sliders (for i3status.conf, i3blocks.conf)
      bspwmSxhkd = { char = ""; code = "nf-fa-F0355"; }; # nf-fa-dot_circle_o (for bspwmrc, sxhkdrc)
      westonConfig = { char = ""; code = "nf-fa-F0367"; }; # nf-fa-lemon_o (for weston.ini)
      linuxKernel = { char = ""; code = "nf-fa-F029C"; }; # nf-fa-linux (for ko files, linux kernel modules)
    };

    # Build Tools
    buildTools = {
      buildGeneric = { char = ""; code = "nf-dev-E63A"; }; # nf-dev-build (used for build, workspace, bazel)
      gradle = { char = ""; code = "nf-seti-E660"; }; # nf-seti-gradle
      grunt = { char = ""; code = "nf-dev-E611"; }; # nf-dev-grunt
      gulp = { char = ""; code = "nf-dev-E610"; }; # nf-dev-gulp
      maven = { char = ""; code = "nf-seti-E674"; }; # nf-seti-maven
      webpack = { char = "󰜫"; code = "nf-md-F072B"; }; # nf-md-webpack
      makefile = { char = ""; code = "nf-dev-E779"; }; # nf-dev-go (used for GNUmakefile and makefile)
      cmake = { char = ""; code = "nf-dev-E615"; }; # nf-dev-terminal (reused from genericConfig)
      justfile = { char = ""; code = "nf-fa-F021D"; }; # nf-fa-upload
      terraform = { char = ""; code = "nf-seti-E69A"; }; # nf-seti-terraform
    };

    # Source Control
    sourceControl = {
      git = { char = ""; code = "nf-dev-E702"; }; # nf-dev-git
    };

    # Editors & IDEs
    editors = {
      vim = { char = ""; code = "nf-dev-E62B"; }; # nf-dev-vim
      vscode = { char = ""; code = "nf-dev-E70C"; }; # nf-dev-visualstudio
      sublime = { char = ""; code = "nf-dev-E7AA"; }; # nf-dev-sublime
    };

    # CAD and 3D Modeling
    cadAnd3d = {
      blender = { char = "󰂫"; code = "nf-md-F00AE"; }; # nf-md-blender
      cadGeneric = { char = "󰻫"; code = "nf-md-F0F6B"; }; # nf-md-cube_scan (generic CAD, for skp, brep, dxf, iges, ifc, sldprt, sldasm, step, stp, ste)
      openSCAD = { char = ""; code = "nf-fa-F034E"; }; # nf-fa-cube
      freecad = { char = ""; code = "nf-linux-F0336"; }; # nf-linux-freecad
      kicad = { char = ""; code = "nf-fa-F034C"; }; # nf-fa-object_group
      _3dModelGeneric = { char = "󰆧"; code = "nf-md-F01A1"; }; # nf-md-cube_outline (generic 3D model, for obj, wrz, wrl, ply, 3mf, stl, fbx)
      prusaslicer = { char = ""; code = "nf-fa-F0351"; }; # nf-fa-tree
      arduino = { char = ""; code = "nf-fa-F034B"; }; # nf-fa-microchip
    };

    # Design and Media
    designAndMedia = {
      illustrator = { char = ""; code = "nf-dev-E7B4"; }; # nf-dev-illustrator
      photoshop = { char = ""; code = "nf-dev-E7B8"; }; # nf-dev-photoshop
      gimp = { char = ""; code = "nf-linux-F0338"; }; # nf-linux-gimp
      material = { char = "󰔉"; code = "nf-md-F0509"; }; # nf-md-palette
      image = { char = ""; code = "nf-dev-E60D"; }; # nf-dev-image (for png, jpg, jpeg, webp, avif, jxl, bmp, ico)
      audio = { char = ""; code = "nf-fa-F0013"; }; # nf-fa-music (for aif, aiff, aac, ape, flac, wvc, pcm, wma, mp3, ogg, opus, wav, wv)
      video = { char = ""; code = "nf-seti-E69F"; }; # nf-seti-video (for mp4, mov, mkv, 3gp, webm, cast, m4v)
      playlist = { char = "󰲹"; code = "nf-md-F0CA5"; }; # nf-md-playlist_music_outline (for m3u, m3u8, pls, cue)
      subtitle = { char = "󰨖"; code = "nf-md-F0A16"; }; # nf-md-subtitles_outline (for lrc, ass, sub, srt, ssa)
      kdenlive = { char = ""; code = "nf-linux-F033C"; }; # nf-linux-kdenlive
      vlc = { char = "󰕼"; code = "nf-md-F057C"; }; # nf-md-play_circle_outline
    };

    # Documents and Ebooks
    documents = {
      markdown = { char = ""; code = "nf-md-F048A"; }; # nf-md-language_markdown (for md, mdx, rmd)
      pdf = { char = ""; code = "nf-cod-EB6B"; }; # nf-cod-file_pdf
      word = { char = "󰈬"; code = "nf-md-F020B"; }; # nf-md-microsoft_word (for doc, docx)
      excel = { char = "󰈛"; code = "nf-md-F021F"; }; # nf-md-microsoft_excel (for xls, xlsx)
      powerpoint = { char = "󰈧"; code = "nf-md-F021A"; }; # nf-md-microsoft_powerpoint (for ppt)
      ebook = { char = ""; code = "nf-fae-E88B"; }; # nf-fae-book_open (for epub, mobi)
      latex = { char = ""; code = "nf-seti-E69B"; }; # nf-seti-tex (for tex, bib)
      bibtex = { char = "󱉟"; code = "nf-md-F125F"; }; # nf-md-text_box
      orgMode = { char = ""; code = "nf-dev-E633"; }; # nf-dev-orgmode
      krita = { char = ""; code = "nf-linux-F033D"; }; # nf-linux-krita
    };

    # Web Development and Frontend
    web = {
      html = { char = ""; code = "nf-dev-E736"; }; # nf-dev-html5
      htmlTemplate = { char = ""; code = "nf-dev-E60E"; }; # nf-dev-html5 (for erb, haml, slim, ejs, pug)
      favicon = { char = ""; code = "nf-dev-E613"; }; # nf-dev-favicon
      css = { char = ""; code = "nf-dev-E749"; }; # nf-dev-css3_alt
      sass = { char = ""; code = "nf-dev-E603"; }; # nf-dev-sass (also for scss)
      stylus = { char = ""; code = "nf-dev-E600"; }; # nf-dev-stylus
      tailwind = { char = "󱏿"; code = "nf-md-F13FF"; }; # nf-md-tailwind_css
      nuxt = { char = "󱄆"; code = "nf-md-F1106"; }; # nf-md-nuxt
      svelte = { char = ""; code = "nf-seti-E697"; }; # nf-seti-svelte
      astro = { char = ""; code = "nf-seti-E6B3"; }; # nf-seti-astro
      twig = { char = ""; code = "nf-dev-E61C"; }; # nf-dev-twig
      laravelBlade = { char = ""; code = "nf-fa-F02F7"; }; # nf-fa-laravel
      xul = { char = ""; code = "nf-dev-E745"; }; # nf-dev-mozilla
      typoscript = { char = ""; code = "nf-dev-E772"; }; # nf-dev-typo3
      robots = { char = "󰚩"; code = "nf-md-F06A9"; }; # nf-md-robot (robots.txt)
      svg = { char = "󰜡"; code = "nf-md-F0721"; }; # nf-md-svg
    };

    # Security related Icons
    security = {
      keepass = { char = ""; code = "nf-fa-F023E"; }; # nf-fa-key
      publicKey = { char = "󰷖"; code = "nf-md-F0DE6"; }; # nf-md-lock_open_variant_outline (for .pub files)
      metasploit = { char = ""; code = "nf-fa-F0370"; }; # nf-fa-metasploit (for msf)
      ascKey = { char = "󰦝"; code = "nf-md-F099D"; }; # nf-md-key (for .asc files)
    };

    # Miscellaneous Icons
    misc = {
      fire = { char = ""; code = "nf-md-F040C"; }; # nf-md-fire (also used for Mojo language)
      xm = { char = ""; code = "nf-seti-E691"; }; # nf-seti-xm (general X and XML related files)
      query = { char = ""; code = "nf-oct-E81C"; }; # nf-oct-search (for general query files)
    };
  };
}
