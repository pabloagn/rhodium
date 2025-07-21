{ pkgs, ... }:
{
  imports = [
    ./age-sops.nix
    ./gpg.nix
  ];
  home.packages = with pkgs; [
    # --- openssl ---
    openssl
  ];
}
