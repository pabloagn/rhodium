{
 description = "Minimal NixOS flake for testing";

 inputs = {
   nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
 };

 outputs = { self, nixpkgs }:
   let
     system = "x86_64-linux";
     pkgs = nixpkgs.legacyPackages.${system};
   in
   {
     # Development shell
     devShells.${system}.default = pkgs.mkShell {
       packages = with pkgs; [
         nixfmt-rfc-style
         nil
       ];
     };

     # Formatter
     formatter.${system} = pkgs.nixfmt-rfc-style;
   };
}
