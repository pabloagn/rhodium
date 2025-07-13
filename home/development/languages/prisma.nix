{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Prisma ---
    nodePackages.prisma # Prisma CLI
    prisma-engines
  ];
}
