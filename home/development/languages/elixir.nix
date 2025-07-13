{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Elixir/erlang ---
    elixir # Binary (includes mix)
    elixir-ls
    erlang-ls
    erlfmt
  ];
}
