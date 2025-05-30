{ config, rhodiumLib, ... }:
let
  icons = config.theme.icons.iconsNerdFont;
  formatIcon = rhodiumLib.formatters.iconFormatter.formatIcon;
in
{
  programs.starship.settings = {
    # Cloud Services
    aws.symbol = formatIcon icons.cloud.aws "☁️";
    gcloud.symbol = formatIcon icons.designAndMedia.material "☁️";

    # Containerization & Virtualization
    docker_context.symbol = formatIcon icons.tech.docker "🐳";

    # Editors
    vim.symbol = formatIcon icons.editors.vim "🗒️";

    # File System & Package Management
    directory.read_only = formatIcon icons.cod.warning "🔒";
    package.symbol = formatIcon icons.files.package "📦";

    # Infrastructure
    terraform.symbol = formatIcon icons.buildTools.terraform "💠";

    # Languages & Runtimes
    conda.symbol = formatIcon icons.programming.python "🅒";
    dart.symbol = formatIcon icons.programming.dart "🎯";
    elixir.symbol = formatIcon icons.programming.elixir "💧";
    elm.symbol = formatIcon icons.seti.elm "🌳";
    golang.symbol = formatIcon icons.programming.go "🐹";
    haskell.symbol = formatIcon icons.programming.haskell "λ ";
    java.symbol = formatIcon icons.programming.java "☕";
    julia.symbol = formatIcon icons.seti.julia "ஃ ";
    lua.symbol = formatIcon icons.programming.lua "🌙";
    nim.symbol = formatIcon icons.programming.nim "🐴";
    nodejs.symbol = formatIcon icons.programming.nodejs "⬢ ";
    perl.symbol = formatIcon icons.programming.perl "🐪";
    php.symbol = formatIcon icons.programming.php "🐘";
    python.symbol = formatIcon icons.programming.python "🐍";
    ruby.symbol = formatIcon icons.programming.ruby "💎";
    rust.symbol = formatIcon icons.programming.rust "🦀";
    scala.symbol = formatIcon icons.programming.scala "🗼";
    swift.symbol = formatIcon icons.programming.swift "🐦";

    # System
    memory_usage.symbol = formatIcon icons.status.info "🧠";
    shlvl.symbol = formatIcon icons.cod.arrow-up "↗️";

    # Version Control
    git_branch.symbol = formatIcon icons.sourceControl.git "🌱";
    hg_branch.symbol = formatIcon icons.cod.arrow-right "☿ ";
  };
}
