{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Tailwind Css ---
    tailwindcss-language-server
  ];
}
