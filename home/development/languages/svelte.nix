{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Svelte ---
    svelte-language-server
  ];
}
