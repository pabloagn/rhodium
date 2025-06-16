{...}: {
  imports = [
    (import ./apps.nix)
    (import ./bookmarks.nix)
    (import ./profiles.nix)
  ];
}
