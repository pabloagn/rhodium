{...}: let
  c = {
    # Normal
    color0 = "#0d0c0c";
    color1 = "#c4746e";
    color2 = "#8a9a7b";
    color3 = "#c4b28a";
    color4 = "#8ba4b0";
    color5 = "#a292a3";
    color6 = "#8ea4a2";
    color7 = "#C8C093";
    # Bright
    color8 = "#A4A7A4";
    color9 = "#E46876";
    color10 = "#87a987";
    color11 = "#E6C384";
    color12 = "#7FB4CA";
    color13 = "#938AA9";
    color14 = "#7AA89F";
    color15 = "#C5C9C7";
    # Extended
    color16 = "#b6927b";
    color17 = "#b98d7b";
    color18 = "#4B5F6F";
    color19 = "#4a7fff";
    color20 = "#59bfaa";
  };

  i = {
    icon01 = "◆";
  };
in let
  viaColor = c.color18;
  colors = c;
in {
  programs.starship.settings = {
    username = {
      format = "[$user]($style)";
      show_always = true;
      style_user = "${colors.color19}";
    };

    hostname = {
      format = "[@$hostname]($style) ";
      style = "${colors.color18}";
      ssh_only = false;
      ssh_symbol = "󰒋 ";
    };

    shlvl = {
      disabled = false;
      format = "[$shlvl]($style) ";
      repeat = true;
      style = "bold ${c.color20}";
      symbol = "T";
      threshold = 3; # HACK: We increase threshold from 2 to 3 since niri creates new shell session, so it always shows 2
    };

    cmd_duration = {
      format = "⑄ [$duration]($style) ";
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
      style = "bold ${colors.color1}";
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
      disabled = true;
    };
    aws = {
      disabled = false;
      symbol = " ";
      format = "${i.icon01}](${viaColor}) [$symbol$profile(\\($region\\))]($style)";
    };
    gcloud = {
      disabled = true;
      format = "${i.icon01}](${viaColor}) [$symbol$active(/$project)(\\($region\\))]($style)";
      symbol = "󱇶 ";
    };
    azure = {
      disabled = true;
      symbol = "󰠅 ";
    };
    openstack = {
      disabled = true;
      symbol = " ";
    };

    # --- Containerization & Virtualization ---
    container = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    docker_context = {
      symbol = "  ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
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
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
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
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    terraform = {
      symbol = "󱁢 ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = false;
    };

    # --- Languages & Runtimes ---
    buf = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    bun = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    c = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    cmake = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    cobol = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    conda = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = false;
    };
    crystal = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    daml = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    dart = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    deno = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    dotnet = {
      symbol = "󰪮 ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    elixir = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = false;
    };
    elm = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    erlang = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = false;
    };
    fennel = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    gleam = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    golang = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = false;
    };
    gradle = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    guix_shell = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    haskell = {
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = false;
      symbol = " ";
      detect_extensions = ["hs" "cabal" "hs-boot"];
      detect_files = ["stack.yaml" "cabal.project" "package.yaml"];
      detect_folders = [];
    };
    haxe = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    helm = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    java = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    julia = {
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      symbol = " ";
      style = "bold #C2736D";
      disabled = false;
      detect_extensions = ["jl"];
      detect_files = ["Project.toml" "Manifest.toml"];
      detect_folders = [];
    };
    kotlin = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
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
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    mise = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    mojo = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    nim = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    nodejs = {
      symbol = "󰎙 ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #2D4F67";
      disabled = false;
    };
    ocaml = {
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      symbol = " ";
      style = "bold #E6C384";
      disabled = false;
      detect_extensions = ["ml" "mli" "re" "rei"];
      detect_files = ["dune-project" "dune" "jbuild" ".merlin" "esy.lock"];
      detect_folders = [];
    };
    odin = {
      format = "[${i.icon01}](${viaColor})[$symbol($version )]($style)";
      symbol = "󰹩 ";
      style = "bold #4d699b";
      disabled = false;
      detect_extensions = ["odin"];
      detect_files = ["ols.json"];
      detect_folders = [];
    };
    opa = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    perl = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    php = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    pixi = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    purescript = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    python = {
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      symbol = " ";
      style = "yellow bold";
      disabled = false;
      python_binary = ["python3" "python"];
      detect_extensions = ["py"];
      detect_files = ["setup.py" "pyproject.toml" "requirements.txt" "__init__.py"];
      detect_folders = [];
    };
    quarto = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    raku = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    red = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    rlang = {
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      symbol = "󰟔 ";
      style = "bold #497EFC";
      disabled = false;
      detect_extensions = ["R" "Rd" "Rmd" "Rproj"];
      detect_files = [".Rprofile" ".Rproj" "renv.lock"];
      detect_folders = [];
    };
    ruby = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    rust = {
      symbol = " ";
      style = "bold ${colors.color1}";
      disabled = false;
      detect_extensions = ["rs"];
      detect_files = ["Cargo.toml" "Cargo.lock"];
      detect_folders = [];
    };
    scala = {
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      symbol = " ";
      style = "bold ${colors.color1}";
      disabled = false;
      detect_extensions = ["scala" "sbt"];
      detect_files = ["build.sbt" "build.sc" "project/build.properties"];
      detect_folders = [];
    };
    solidity = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    swift = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    typst = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = false;
    };
    vlang = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
      style = "bold #462941";
      disabled = true;
    };
    zig = {
      symbol = " ";
      format = "[${i.icon01}](${viaColor}) [$symbol($version )]($style)";
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
    git_branch = {
      disabled = false;
      format = "${i.icon01}](${viaColor}) [$symbol$branch]($style) ";
      style = "bold ${c.color8}";
      symbol = " ";
    };
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
      style = "bold ${colors.color1}";
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
    git_metrics = {
      disabled = false;
      added_style = "bold ${colors.color12}";
      deleted_style = "bold ${colors.color9}";
      format = "([\\[[$added]($added_style) ± [$deleted]($deleted_style)\\]]($added_style) )";
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
}
