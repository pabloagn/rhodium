{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Protocol Buffers ---
    buf
  ];
}
