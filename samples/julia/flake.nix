{
  description = "Julia LSP Environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    {
      devShells.default =
        let
          pkgs = import nixpkgs {
            system = "x86_64-linux";
          };
        in
        {
          default = pkgs.mkShell {
            packages = [
              (pkgs.julia.withPackages (
                ps: with ps; [
                  LanguageServer
                  SymbolServer
                  StaticLint
                ]
              ))
            ];
          };
        };
    };
}
