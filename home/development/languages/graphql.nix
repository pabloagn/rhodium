{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Graphql (as Nodepackage) ---
    nodePackages.graphql-language-service-cli
  ];
}
