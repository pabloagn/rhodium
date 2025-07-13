{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Scala ---
    metals # Language server
    scalafmt # Formatter
  ];
}
