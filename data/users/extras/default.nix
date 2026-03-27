{ ... }:
{
  imports = [
    (import ./apps.nix)
    (import ./bookmarks.nix)
    (import ./osmium.nix)
    (import ./profiles.nix)
  ];
}
