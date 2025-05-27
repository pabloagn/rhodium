{ config, rhodiumLib, ... }:
let
  iconTokensNF = config.theme.icons.iconsNerdFont;
  formatIcon = rhodiumLib.formatters.iconFormatter.formatIcon;
in
{
  programs.starship.settings = {
    # Cloud Services
    aws.symbol = formatIcon iconTokensNF.cloud.aws " ";
    gcloud.symbol = formatIcon iconTokensNF.designAndMedia.material " ";

    # Containerization & Virtualization
    docker_context.symbol = formatIcon iconTokensNF.tech.docker " ";

    # Editors
    vim.symbol = formatIcon iconTokensNF.editors.vim " ";

    # File System & Package Management
    directory.read_only = formatIcon iconTokensNF.status.warning " ";
    package.symbol = formatIcon iconTokensNF.tech.settings "󰏗 ";

    # Infrastructure
    terraform.symbol = formatIcon iconTokensNF.buildTools.terraform "󱁢";

    # Languages & Runtimes
    conda.symbol = formatIcon iconTokensNF.programming.python " ";
    dart.symbol = formatIcon iconTokensNF.programming.dart " ";
    elixir.symbol = formatIcon iconTokensNF.programming.elixir " ";
    elm.symbol = formatIcon iconTokensNF.programming.elm " ";
    golang.symbol = formatIcon iconTokensNF.programming.go " ";
    haskell.symbol = formatIcon iconTokensNF.programming.haskell " ";
    java.symbol = formatIcon iconTokensNF.programming.java " ";
    julia.symbol = formatIcon iconTokensNF.programming.julia " ";
    lua.symbol = formatIcon iconTokensNF.programming.lua " ";
    nim.symbol = formatIcon iconTokensNF.programming.nim "󰆥 ";
    nodejs.symbol = formatIcon iconTokensNF.programming.nodejs " ";
    perl.symbol = formatIcon iconTokensNF.programming.perl " ";
    php.symbol = formatIcon iconTokensNF.programming.php " ";
    python.symbol = formatIcon iconTokensNF.programming.python " ";
    ruby.symbol = formatIcon iconTokensNF.programming.ruby " ";
    rust.symbol = formatIcon iconTokensNF.programming.rust " ";
    scala.symbol = formatIcon iconTokensNF.programming.scala " ";
    swift.symbol = formatIcon iconTokensNF.programming.swift "󰛥 ";

    # System
    memory_usage.symbol = formatIcon iconTokensNF.status.info "󰍛 ";
    shlvl.symbol = formatIcon iconTokensNF.arrows.up "";

    # Version Control
    git_branch.symbol = formatIcon iconTokensNF.sourceControl.git " ";
    hg_branch.symbol = formatIcon iconTokensNF.arrows.right " ";
  };
}
