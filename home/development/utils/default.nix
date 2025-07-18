{ pkgs, ... }:
{
  home.packages = with pkgs; [
    devenv # Easy developer environments
    graphviz # Graph visualization tools
    nodePackages.prettier
    prettierd # Prettier formatter as daemon for improved speed
    rlwrap # Using for CommonLisp
    socat # Using for CommonLisp
    tree-sitter # Parser generator
  ];
}
