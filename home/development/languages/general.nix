{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- General ---
    devenv # Easy developer environments
    graphviz # Graph visualization tools
    nodePackages.prettier # Fallback prettier
    prettierd # NOTE: Prettier running as daemon
    rlwrap # Using for CommonLisp
    socat # Using for CommonLisp
    tree-sitter # Parser generator
  ];
}
