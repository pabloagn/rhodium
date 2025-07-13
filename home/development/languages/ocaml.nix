{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Ocaml ---
    ocamlPackages.ocaml-lsp
    ocamlPackages.ocamlformat
    ocamlPackages.dune_3
    ocamlPackages.utop
    ocamlPackages.ocp-indent
    ocamlPackages.merlin
  ];
}
