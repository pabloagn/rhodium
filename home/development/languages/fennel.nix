{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Fennel ---
    fennel-ls # Language server
  ];
}
