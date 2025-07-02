{
  config,
  rhodiumLib,
  ...
}: let
  getIcon = rhodiumLib.formatters.iconFormatter.getIcon;
  viaIcon = "◆";
in {
  programs.starship.settings = {
    username = {
      format = "[$user]($style)";
      show_always = true;
      style_user = "#4a7fff";
    };

    hostname = {
      format = "[@$hostname]($style) ";
      style = "#4C6070";
      ssh_only = false;
      ssh_symbol = "󰒋 ";
    };

    shlvl = {
      disabled = false;
      format = "[$shlvl]($style) ";
      repeat = true;
      style = "bold #59bfaa";
      symbol = "T";
      threshold = 3; # HACK: We increase threshold from 2 to 3 since niri creates new shell session, so it always shows 2
    };

    cmd_duration = {
      format = "⋈ [$duration]($style) ";
      style = "#928A7C";
    };

    directory = {
      fish_style_pwd_dir_length = 1;
      format = "[$path]($style) ";
      read_only = "⌽ ";
      style = "#4a7fff";
      truncate_to_repo = true;
      truncation_length = 3;
    };

    nix_shell = {
      format = "[($name <- )$symbol]($style) ";
      impure_msg = "impure";
      style = "bold #c4746e";
      symbol = " ";
      pure_msg = "pure";
      unknown_msg = "";
      disabled = false;
      heuristic = false;
    };

    character = {
      error_symbol = "[->>](bold #E46876)";
      success_symbol = "[->>](bold #445564)";
      vimcmd_replace_one_symbol = "[<<-](bold #5a5c8a)";
      vimcmd_replace_symbol = "[<<-](bold #5a5c8a)";
      vimcmd_symbol = "[<<-](bold #d4bf94)";
      vimcmd_visual_symbol = "[<<-](bold #59bfaa)";
    };

    time = {
      format = "\\[[$time]($style)\\]";
      style = "#4B5F6F";
      disabled = false;
    };

    git_branch = {
      format = "[$symbol$branch]($style) ";
      style = "bold #A4A7A4";
      symbol = " ";
    };

    python = {
      format = "[${viaIcon}](#4B5F6F) [$symbol($version )]($style)";
      symbol = " ";
      style = "yellow bold";
      disabled = false;
      python_binary = ["python3" "python"];
      detect_extensions = ["py"];
      detect_files = ["setup.py" "pyproject.toml" "requirements.txt" "__init__.py"];
      detect_folders = [];
    };

    aws = {
      symbol = " ";
      format = "on [$symbol$profile(\\($region\\))]($style)";
      disabled = true;
    };
    gcloud = {
      format = "on [$symbol$active(/$project)(\\($region\\))]($style)";
      symbol = "󱇶 ";
      disabled = true;
    };
    azure = {
      symbol = "󰠅 ";
      disabled = true;
    };
    openstack = {
      symbol = " ";
      disabled = true;
    };

    # --- Containerization & Virtualization ---
    container = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    docker_context = {
      symbol = "  ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = false;
    };
    kubernetes = {
      symbol = "󱃾 ";
      format = "[$symbol$context( \\($namespace\\))]($style) ";
      style = "cyan bold";
      disabled = false;
      detect_extensions = [];
      detect_files = ["k8s.yaml" "kubernetes.yaml" ".kubeconfig"];
      detect_folders = [".kube"];
      detect_env_vars = ["KUBECONFIG"];
    };
    vagrant = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };

    # --- File System & Package Management ---
    package = {
      symbol = "󰏗 ";
      disabled = false;
    };

    # --- Infrastructure & DevOps ---
    direnv = {
      symbol = " ";
      disabled = true;
    };
    pulumi = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    terraform = {
      symbol = "󱁢 ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = false;
    };

    # --- Languages & Runtimes ---
    buf = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    bun = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    c = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    cmake = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    cobol = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    conda = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = false;
    };
    crystal = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    daml = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    dart = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    deno = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    dotnet = {
      symbol = "󰪮 ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    elixir = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = false;
    };
    elm = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    erlang = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = false;
    };
    fennel = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    gleam = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    golang = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = false;
    };
    gradle = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    guix_shell = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    haskell = {
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = false;
      symbol = " ";
      detect_extensions = ["hs" "cabal" "hs-boot"];
      detect_files = ["stack.yaml" "cabal.project" "package.yaml"];
      detect_folders = [];
    };
    haxe = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    helm = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    java = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    julia = {
      format = "via [$symbol($version )]($style)";
      symbol = " ";
      style = "bold #C2736D";
      disabled = false;
      detect_extensions = ["jl"];
      detect_files = ["Project.toml" "Manifest.toml"];
      detect_folders = [];
    };
    kotlin = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    lua = {
      symbol = " ";
      format = "via [$symbol($version )]($style)";
      style = "bold #2D4F67";
      disabled = false;
      detect_extensions = ["lua"];
      detect_files = [".luarc.json" ".luacheckrc" "stylua.toml"];
      detect_folders = [];
    };
    meson = {
      symbol = "󰔷 ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    mise = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    mojo = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    nim = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    nodejs = {
      symbol = "󰎙 ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #2D4F67";
      disabled = false;
    };
    ocaml = {
      format = "via [$symbol($version )]($style)";
      symbol = " ";
      style = "bold #E6C384";
      disabled = false;
      detect_extensions = ["ml" "mli" "re" "rei"];
      detect_files = ["dune-project" "dune" "jbuild" ".merlin" "esy.lock"];
      detect_folders = [];
    };
    odin = {
      format = "via [$symbol($version )]($style)";
      symbol = "󰹩 ";
      style = "bold #4d699b";
      disabled = false;
      detect_extensions = ["odin"];
      detect_files = ["ols.json"];
      detect_folders = [];
    };
    opa = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    perl = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    php = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    pixi = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    purescript = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    quarto = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    raku = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    red = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    rlang = {
      format = "via [$symbol($version )]($style)";
      symbol = "󰟔 ";
      style = "bold #497EFC";
      disabled = false;
      detect_extensions = ["R" "Rd" "Rmd" "Rproj"];
      detect_files = [".Rprofile" ".Rproj" "renv.lock"];
      detect_folders = [];
    };
    ruby = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    rust = {
      symbol = " ";
      style = "bold #c4746e";
      disabled = false;
      detect_extensions = ["rs"];
      detect_files = ["Cargo.toml" "Cargo.lock"];
      detect_folders = [];
    };
    scala = {
      format = "via [$symbol($version )]($style)";
      symbol = " ";
      style = "bold #c4746e";
      disabled = false;
      detect_extensions = ["scala" "sbt"];
      detect_files = ["build.sbt" "build.sc" "project/build.properties"];
      detect_folders = [];
    };
    solidity = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    swift = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    typst = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = false;
    };
    vlang = {
      symbol = " ";
      format = "${viaIcon} [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    zig = {
      symbol = " ";
      format = "via [$symbol($version )]($style)";
      style = "bold yellow";
      disabled = false;
      detect_extensions = ["zig" "zon"];
      detect_files = ["build.zig" "build.zig.zon"];
      detect_folders = [];
    };

    # --- Shells ---
    shell = {
      format = "[$indicator]($style) ";
      style = "white dimmed";
      disabled = true;
      bash_indicator = " ";
      fish_indicator = "󰈺 ";
      zsh_indicator = " ";
      powershell_indicator = "󰨊 ";
      ion_indicator = " ";
      elvish_indicator = " ";
      tcsh_indicator = " ";
      xonsh_indicator = " ";
      cmd_indicator = " ";
      nu_indicator = " ";
      unknown_indicator = " ";
    };

    # --- System & Environment ---
    battery = {
      disabled = true;
      full_symbol = "󰁹 ";
      charging_symbol = "󰂄 ";
      discharging_symbol = "󰂃 ";
      unknown_symbol = "󰁽 ";
      empty_symbol = "󰂎 ";
    };
    jobs = {
      symbol = "⛭ ";
    };
    localip = {
      symbol = "󰩟 ";
    };
    memory_usage = {
      symbol = "󰍛 ";
    };
    os.symbols = {
      AIX = " ";
      Alpaquita = " ";
      AlmaLinux = " ";
      Alpine = " ";
      Amazon = " ";
      Android = " ";
      Arch = " ";
      Artix = " ";
      CentOS = " ";
      Debian = " ";
      DragonFly = " ";
      Emscripten = " ";
      EndeavourOS = " ";
      Fedora = " ";
      FreeBSD = " ";
      Garuda = " ";
      Gentoo = " ";
      HardenedBSD = "󰞌 ";
      Illumos = "󰈸 ";
      Linux = " ";
      Mabox = " ";
      Macos = " ";
      Manjaro = " ";
      Mariner = " ";
      MidnightBSD = " ";
      Mint = " ";
      NetBSD = " ";
      NixOS = " ";
      OpenBSD = " ";
      openSUSE = " ";
      OracleLinux = "󰌷 ";
      Pop = " ";
      Raspbian = " ";
      Redhat = " ";
      RedHatEnterprise = " ";
      RockyLinux = " ";
      Redox = "󰀘 ";
      Solus = "󰠳 ";
      SUSE = " ";
      Ubuntu = " ";
      Unknown = " ";
      Windows = " ";
    };
    status = {
      symbol = "✗";
      success_symbol = "✓";
      not_executable_symbol = "⊘";
      not_found_symbol = "?";
      sigint_symbol = "⊗";
      signal_symbol = "∿";
    };
    sudo = {
      symbol = "♰";
    };

    # --- Version Control ---
    git_state = {
      am = "✉";
      am_or_rebase = "⟳";
      bisect = "⊟";
      cherry_pick = "✓";
      merge = "⤝";
      rebase = "↻";
      revert = "↺";
    };
    git_status = {
      format = "([\\[$all_status$ahead_behind\\]]($style) )";
      style = "bold #c4746e";
      ahead = "⇡";
      behind = "⇣";
      conflicted = "=";
      deleted = "✗";
      diverged = "⇕";
      modified = "!";
      renamed = "»";
      staged = "+";
      stashed = "$";
      typechanged = "⊙";
      untracked = "?";
      up_to_date = "✓";
    };
    git_commit = {
      tag_symbol = "◈";
    };

    # --- Others ---
    fossil_branch = {
      symbol = "⌘";
    };
    hg_branch = {
      symbol = "☿";
    };
    pijul_channel = {
      symbol = "⊶";
    };
    vcsh = {
      symbol = "∇";
    };

    # --- Networking ---
    nats = {
      symbol = " ";
    };
    netns = {
      symbol = "󰀂 ";
    };

    # --- Environment Variables ---
    env_var = {
      symbol = " ";
    };

    # --- Misc ---
    fill = {
      symbol = " ";
    };
    line_break = {
      disabled = false;
    };
    spack = {
      symbol = " ";
    };
    singularity = {
      symbol = " ";
    };
  };
  custom = {
    clojure = {
      description = "Shows Clojure project";
      when = ''
        test -f project.clj || \
        test -f deps.edn || \
        test -f build.boot || \
        test -f shadow-cljs.edn || \
        test -f bb.edn
      '';
      command = ''
        if command -v clojure >/dev/null 2>&1; then
          clojure -version 2>&1 | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | head -1
        else
          echo "project"
        fi
      '';
      format = "${viaIcon} [ $output]($style) ";
      style = "bold green";
    };

    astro = {
      description = "Shows Astro project";
      when = ''
        test -f astro.config.mjs || \
        test -f astro.config.js || \
        test -f astro.config.ts || \
        find . -maxdepth 1 -name "*.astro" 2>/dev/null | grep -q .
      '';
      command = ''
        if [ -f package.json ] && grep -q '"astro"' package.json 2>/dev/null; then
          grep '"astro":' package.json | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | head -1
        else
          echo "project"
        fi
      '';
      format = "${viaIcon} [ $output]($style) ";
      style = "bold purple";
    };

    typescript = {
      description = "Shows TypeScript project";
      when = ''
        test -f tsconfig.json || \
        test -f tsconfig.base.json || \
        find . -maxdepth 1 -name "*.ts" -o -name "*.tsx" 2>/dev/null | grep -q .
      '';
      command = ''
        if command -v tsc >/dev/null 2>&1; then
          tsc --version | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+'
        else
          echo "project"
        fi
      '';
      format = "${viaIcon} [ $output]($style) ";
      style = "bold blue";
    };

    assembly = {
      description = "Shows Assembly project";
      when = ''
        find . -maxdepth 1 \( -name "*.asm" -o -name "*.s" -o -name "*.S" \) 2>/dev/null | grep -q .
      '';
      command = ''
        if command -v nasm >/dev/null 2>&1; then
          echo "nasm"
        elif command -v gas >/dev/null 2>&1; then
          echo "gas"
        else
          echo "asm"
        fi
      '';
      format = "${viaIcon} [ $output]($style) ";
      style = "bold red";
    };

    ada = {
      description = "Shows Ada project";
      when = ''
        test -f alire.toml || \
        test -f project.gpr || \
        find . -maxdepth 1 \( -name "*.ads" -o -name "*.adb" \) 2>/dev/null | grep -q .
      '';
      command = ''
        if command -v gnatmake >/dev/null 2>&1; then
          gnatmake --version | head -1 | grep -o '[0-9]\+\.[0-9]\+'
        else
          echo "project"
        fi
      '';
      format = "${viaIcon} [ $output]($style) ";
      style = "bold cyan";
    };

    agda = {
      description = "Shows Agda project";
      when = ''
        test -f .agda-lib || \
        find . -maxdepth 1 -name "*.agda" 2>/dev/null | grep -q .
      '';
      command = ''
        if command -v agda >/dev/null 2>&1; then
          agda --version | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | head -1
        else
          echo "project"
        fi
      '';
      format = "${viaIcon} [ $output]($style) ";
      style = "bold yellow";
    };

    angular = {
      description = "Shows Angular project";
      when = ''
        test -f angular.json || \
        test -f .angular-cli.json || \
        test -f angular-cli.json
      '';
      command = ''
        if [ -f package.json ] && grep -q '"@angular/core"' package.json 2>/dev/null; then
          grep '"@angular/core":' package.json | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | head -1
        else
          echo "project"
        fi
      '';
      format = "${viaIcon} [ $output]($style) ";
      style = "bold red";
    };
  };
}
