{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Deno ---
    # Alt Typescript Runtime
    deno
  ];
}
