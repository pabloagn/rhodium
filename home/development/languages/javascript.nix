{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Javascript/Typescript/React.js/Next.js ---
    nodejs # Node.js JavaScript runtime
    nodePackages.eslint
    nodePackages.npm
    nodePackages.prettier
    nodePackages.typescript-language-server
    biome
  ];
}
