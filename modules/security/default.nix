{ ... }:
{
  imports = [
    # ./auth.nix
    ./ssh.nix
    ./sops.nix
    ./sudo.nix
    ./tailscale.nix
    ./keyrings.nix
  ];
}
