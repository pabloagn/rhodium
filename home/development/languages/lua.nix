{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Lua ---
    lua-language-server
    stylua
  ];
}
