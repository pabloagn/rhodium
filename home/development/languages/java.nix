{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Java ---
    google-java-format
    jdt-language-server # Eclipse JDT LS
  ];
}
