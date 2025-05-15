# modules/development/languages/default.nix

{
  imports = [
    ./nix.nix
    ./c.nix
    ./cpp.nix
    ./python.nix
    ./go.nix
    ./rust.nix
    ./lua.nix
  ];
}
