{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Prisma ---
    prisma-engines
  ];
}
