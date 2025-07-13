{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Bash/shell ---
    bash-language-server
    shfmt # Shell formatter
    shellcheck # Shell linter
  ];
}
