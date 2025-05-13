# modules/core/default.nix

{
  imports = [
    ./boot.nix
    ./security.nix
    ../profiles/options.nix
  ];
}
