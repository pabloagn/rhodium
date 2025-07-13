{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Elixir/erlang ---
    elixir-ls
    erlang-ls
    erlfmt
  ];
}
