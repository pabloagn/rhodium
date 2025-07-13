{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- C#/.net/f# ---
    omnisharp-roslyn
  ];
}
