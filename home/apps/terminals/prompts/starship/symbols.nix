{...}: {
  programs.starship.settings = {
    # --- Cloud Services ---
    aws = {
      symbol = " ";
      format = "on [$symbol$profile(\\($region\\))]($style)";
    };
    gcloud = {
      format = "on [$symbol$active(/$project)(\\($region\\))]($style)";
      symbol = "󱇶 ";
    };
    azure.symbol = "󰠅 ";
    openstack.symbol = " ";

    # --- Containerization & Virtualization ---
    container.symbol = " ";
    docker_context.symbol = "  ";
    kubernetes.symbol = "󱃾 ";
    vagrant.symbol = " ";

    # --- File System & Package Management ---
    directory.read_only = " ";
    package.symbol = "󰏗 ";

    # --- Infrastructure & DevOps ---
    direnv.symbol = " ";
    pulumi.symbol = " ";
    terraform.symbol = "󱁢 ";

    # --- Languages & Runtimes ---
    buf.symbol = " ";
    bun.symbol = " ";
    c.symbol = " ";
    cmake.symbol = " ";
    cobol.symbol = " ";
    conda.symbol = " ";
    crystal.symbol = " ";
    daml.symbol = " ";
    dart.symbol = " ";
    deno.symbol = " ";
    dotnet.symbol = "󰪮 ";
    elixir.symbol = " ";
    elm.symbol = " ";
    erlang.symbol = " ";
    fennel.symbol = " ";
    gleam.symbol = " ";
    golang.symbol = " ";
    gradle.symbol = " ";
    guix_shell.symbol = " ";
    haskell.symbol = " ";
    haxe.symbol = " ";
    helm.symbol = " ";
    java.symbol = " ";
    julia.symbol = " ";
    kotlin.symbol = " ";
    lua.symbol = " ";
    meson.symbol = "󰔷 ";
    mise.symbol = " ";
    mojo.symbol = " ";
    nim.symbol = "󰆥 ";
    nodejs.symbol = " ";
    ocaml.symbol = " ";
    odin.symbol = "󰹩 ";
    opa.symbol = " ";
    perl.symbol = " ";
    php.symbol = " ";
    pixi.symbol = " ";
    purescript.symbol = " ";
    python.symbol = " ";
    quarto.symbol = " ";
    raku.symbol = " ";
    red.symbol = " ";
    rlang.symbol = "󰟔 ";
    ruby.symbol = " ";
    rust.symbol = " ";
    scala.symbol = " ";
    solidity.symbol = " ";
    swift.symbol = " ";
    typst.symbol = " ";
    vlang.symbol = " ";
    zig.symbol = " ";

    # --- Shells ---
    shell.bash_indicator = " ";
    shell.fish_indicator = "󰈺 ";
    shell.zsh_indicator = " ";
    shell.powershell_indicator = "󰨊 ";
    shell.ion_indicator = " ";
    shell.elvish_indicator = " ";
    shell.tcsh_indicator = " ";
    shell.xonsh_indicator = " ";
    shell.cmd_indicator = " ";
    shell.nu_indicator = " ";
    shell.unknown_indicator = " ";

    # --- System & Environment ---
    battery = {
      full_symbol = "󰁹 ";
      charging_symbol = "󰂄 ";
      discharging_symbol = "󰂃 ";
      unknown_symbol = "󰁽 ";
      empty_symbol = "󰂎 ";
    };
    cmd_duration.symbol = " ";
    hostname.ssh_symbol = "󰒋 ";
    jobs.symbol = "⛭ ";
    localip.symbol = "󰩟 ";
    memory_usage.symbol = "󰍛 ";
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
    shlvl.symbol = "T";
    status = {
      symbol = "✗";
      success_symbol = "✓";
      not_executable_symbol = "⊘";
      not_found_symbol = "?";
      sigint_symbol = "⊗";
      signal_symbol = "∿";
    };
    sudo.symbol = "⚿";
    time.symbol = "⌀";
    username.symbol = "⊙";

    # --- Version Control ---
    # Git
    git_state = {
      rebase = "↻";
      merge = "⤝";
      revert = "↺";
      cherry_pick = "✓";
      bisect = "⊟";
      am = "✉";
      am_or_rebase = "⟳";
    };
    git_status = {
      format = "([\\[$all_status$ahead_behind\\]]($style) )";
      conflicted = "=";
      ahead = "⇡";
      behind = "⇣";
      diverged = "⇕";
      up_to_date = "✓";
      untracked = "?";
      stashed = "$";
      modified = "!";
      staged = "+";
      renamed = "»";
      deleted = "✗";
      typechanged = "⊙";
    };
    git_commit.tag_symbol = "◈";

    # Others
    fossil_branch.symbol = "⌘";
    hg_branch.symbol = "☿";
    pijul_channel.symbol = "⊶";
    vcsh.symbol = "∇";

    # --- Networking ---
    nats.symbol = " ";
    netns.symbol = "󰀂 ";

    # --- Environment Variables ---
    env_var.symbol = " ";

    # --- Misc ---
    fill.symbol = " ";
    line_break.disabled = false;
    spack.symbol = " ";
    singularity.symbol = " ";
  };
}
