{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Just ---
    just # Alternative to Make - command runner
    just-lsp
  ];
}
