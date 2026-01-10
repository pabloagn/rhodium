{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Javascript/Typescript/React.js/Next.js ---
    nodejs # Node.js JavaScript runtime (includes npm)
    nodePackages.eslint
    # nodePackages.npm # Already included in nodejs
    nodePackages.prettier
    nodePackages.typescript-language-server
    biome
  ];
}
