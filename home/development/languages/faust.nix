{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Faust ---
    faust # Functional language for real-time audio signal processing
  ];
}
