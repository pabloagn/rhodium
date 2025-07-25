{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Just ---
    julia
  ];
}
